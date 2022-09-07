// Code by www.lidia-martinez.com . Get updated versions there. Use it freely.

using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

/// <summary>
/// This is a workaround to the very serious problem that RaycastCommand doesn't use "maxhits" parameter even though
/// it is available in the API and the Docs. It always returns one hit maximum. 
/// Here we can perform several hits and combine them. Depending on the number of commands and hits, it will get a lot slower
/// than the original RaycastCommand.ScheduleBatch. Try to keep the values as low as possible.
/// 
/// TODO: Restore raycastCommands data after the process, instead of just the FROM position without additional overhead.
/// TODO: Stop the process if all hits failed. A shared boolean or counter would not work in this chain of already created jobs.
/// </summary>
public static class RaycastCommandMultihit
{
    ///<summary>Similar than RaycastCommand.ScheduleBatch but maxHits is supported.</summary>
    /// <param name="commands">IMPORTANT: Ensure that maxHits are 1 in each RaycastCommand in this array. Will be reused so distances and nhits will be deleted. From will be kept.</param>
    /// <param name="results">Same format than RacastCommand results. Indexing: Ray index * maxHits + hit index</param>
    /// <param name="maxHits">Max hits allowed per command</param>
    /// <param name="minCommandsPerJob">Batch size for each job. For this size of job, around 32 and 64 is fine.</param>
    /// <param name="minStep">A small distance to add for each subsequent ray, to avoid hitting the same objects again</param>
    public static JobHandle ScheduleBatch(NativeArray<RaycastCommand> commands, NativeArray<RaycastHit> results, int minCommandsPerJob, int maxHits, JobHandle dependsOn = default, float minStep = 0.0001f)
    {
        if (maxHits <= 0)
            throw new System.ArgumentException("maxHits should be greater than zero");

        if (results.Length < commands.Length * maxHits)
            throw new System.ArgumentException("Results array length does not match maxHits count");

        if (minStep < 0f)
            throw new System.ArgumentException("minStep should be more or equal to zero");

        if (maxHits == 1)
            return RaycastCommand.ScheduleBatch(commands, results, minCommandsPerJob, dependsOn);
            
        var intermediateResults = new NativeArray<RaycastHit>(commands.Length, Allocator.TempJob);
        var nHits = new NativeArray<int>(commands.Length, Allocator.TempJob);
        var distanceSum = new NativeArray<float>(commands.Length, Allocator.TempJob);
            
        int counter = 0;
        while (counter < maxHits)
        {
            dependsOn = RaycastCommand.ScheduleBatch(commands, intermediateResults, minCommandsPerJob, dependsOn);
                
            // Read results, if any hit, create a new command for the new batch. Otherwise, create a default RaycastCommand.
            var job = new GatherHitsAndCreateNewCommands
            {
                commands = commands,
                results = intermediateResults,
                finalResults = results,
                distanceSum = distanceSum,
                nHits = nHits,
                minStep = minStep,
                maxHits = maxHits
            };
            dependsOn = job.Schedule(commands.Length, minCommandsPerJob, dependsOn);

            counter++;
        }

        dependsOn.Complete();

        intermediateResults.Dispose();
        distanceSum.Dispose();
        nHits.Dispose();

        return dependsOn;
    }
        
    private struct GatherHitsAndCreateNewCommands : IJobParallelFor
    {
        /// <summary> The last batch commands </summary>
        public NativeArray<RaycastCommand> commands;

        /// <summary> Results returned by the last batch </summary>
        [ReadOnly] public NativeArray<RaycastHit> results;

        /// <summary> A small offset added to each ray after a hit (to avoid hitting the same items) </summary>
        [ReadOnly] public float minStep;

        /// <summary> Number of hits at the end </summary>
        [ReadOnly] public int maxHits;

        /// <summary> To write only succesful intermediate hits if any </summary>
        [WriteOnly] [NativeDisableParallelForRestriction] public NativeArray<RaycastHit> finalResults;

        /// <summary> Distance passed to the actual hits (ignoring small offsets added) </summary>
        public NativeArray<float> distanceSum;

        /// <summary> Stored for each ray to choose the correct position on the results array </summary>
        public NativeArray<int> nHits;

        public void Execute(int index)
        {
            var command = commands[index];
            var result = results[index];

            // No hit, then do not execute this ray anymore in the next batch
            int colliderInstanceId = GetColliderID(result);
            if (colliderInstanceId == 0)
            {
                // Restore from at least. But next step should not return any hit.
                command.distance = 0;
                command.maxHits = 0;
                command.from -= command.direction * distanceSum[index];
                commands[index] = command;
                finalResults[index * maxHits + nHits[index]] = default;
            }

            // Hit happened
            else
            {
                // Add fake minstep por the first hit that didn't add it
                if (nHits[index] == 0)
                {
                    result.distance -= minStep;
                    command.from += command.direction * minStep;
                    command.distance -= minStep;
                }

                // Create new hit, moving forward a little bit using "minStep"
                command.from = command.from + command.direction * (result.distance + minStep);
                command.distance = command.distance - result.distance - minStep;
                commands[index] = command;

                // Store hit
                result.distance += distanceSum[index] + minStep; // Add an additional first step
                finalResults[index * maxHits + nHits[index]] = result;
                nHits[index] = nHits[index] + 1;
                distanceSum[index] += result.distance + minStep;
            }
        }

        //NOTE: This hack given by the Unity support team is needed to be able to access 
        // the raycashit collider from raycast hits returned by RaycastCommand.Schedule
        // in order to take advantage of jobs afterwards. A UnityEngine class is not accessible 
        // from a job.
        /// TODO: Unity support team said that this is fixed in 2021.2 version. In the meantime, use this
        [StructLayout(LayoutKind.Sequential)]
        private struct RaycastHitPublic
        {
            public Vector3 m_Point;
            public Vector3 m_Normal;
            public int m_FaceID;
            public float m_Distance;
            public Vector2 m_UV;
            public int m_ColliderID;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private static int GetColliderID(RaycastHit hit)
        {
            unsafe
            {
                RaycastHitPublic h = *(RaycastHitPublic*)&hit;
                return h.m_ColliderID;
            }
        }
    }
}
