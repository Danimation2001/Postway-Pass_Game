using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyController : MonoBehaviour
{
    Transform _target; // the player
    public float detectionRadius; // how close the player needs to be to be detected
    NavMeshAgent _agent; // navmeshagent component
    public float wanderSpeed = 1f; // how fast the enemy moves whilst wandering
    float _chaseSpeed; // how fast the enemy moves whilst chasing. use speed on agent component to change
    public Transform wanderDestination; // position to move towards when wandering
    public float wanderRadius; // how far the enemy can wander away from
    public float wanderTimer; // time it takes to choose a new destination
    float _timer;
    Vector3 _wanderArea; // origin of wandering area.

    void OnEnable() // initialize variables
    {
        _agent = GetComponent<NavMeshAgent>();
        _timer = wanderTimer;
        _target = GameObject.FindGameObjectWithTag("Player").transform;
        wanderDestination.position = transform.position;
        _chaseSpeed = _agent.speed;
        _wanderArea = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        float _distance = Vector3.Distance(_target.position, transform.position); // distance between enemy and player
        _timer += Time.deltaTime; // increase timer

        if (_distance > detectionRadius) // if the player isn't within detection range
        {
            _agent.speed = wanderSpeed; // set the speed to wandering speed

            if (_timer >= wanderTimer) // if it has been long enough to choose a new wander destination
            {
                StartCoroutine(Wander());
                _timer = 0; // reset timer
            }
        }

        if (_distance <= detectionRadius) // if the player is within detection range
        {
            _agent.speed = _chaseSpeed; // set speed to chase speed
            _agent.SetDestination(_target.position); // chase the player
        }
    }

    IEnumerator Wander() // move to a random wander position
    {
        wanderDestination.position = RandomNavSphere(_wanderArea, wanderRadius, -1); // choose random position within a sphere radius of the wander area
        _agent.SetDestination(wanderDestination.position); // move towards the chosen position
        yield return new WaitForSeconds(2f); // wait
    }

    public static Vector3 RandomNavSphere(Vector3 origin, float distance, int layermask) // setup a sphere to wander within that gets a random point within the radius on the navmesh
    {
        Vector3 randDirection = Random.insideUnitSphere * distance;

        randDirection += origin;

        NavMeshHit navHit;

        NavMesh.SamplePosition(randDirection, out navHit, distance, layermask);

        return navHit.position;
    }

    void OnDrawGizmosSelected() // lets us see the detection radius in the editor
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, detectionRadius);
    }
}