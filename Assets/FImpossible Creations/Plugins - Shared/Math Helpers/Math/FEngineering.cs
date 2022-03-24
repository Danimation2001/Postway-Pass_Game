using UnityEngine;


namespace FIMSpace
{
    /// <summary>
    /// FM: Class which contains many helpful methods which operates on Vectors and Quaternions or some other floating point maths
    /// </summary>
    public static class FEngineering
    {


        #region Rotations and directions


        public static bool VIsZero(this Vector3 vec)
        {
            if (vec.sqrMagnitude == 0f) return true; return false;
            //if (vec.x != 0f) return false; if (vec.y != 0f) return false; if (vec.z != 0f) return false; return true;
        }

        public static bool VIsSame(this Vector3 vec1, Vector3 vec2)
        {
            if (vec1.x != vec2.x) return false; if (vec1.y != vec2.y) return false; if (vec1.z != vec2.z) return false; return true;
        }


        public static Vector3 TransformVector(this Quaternion parentRot, Vector3 parentLossyScale, Vector3 childLocalPos)
        {
            return parentRot * Vector3.Scale(childLocalPos, parentLossyScale);
        }

        /// <summary> Same like transform vector but without scaling but also supporting negative scale </summary>
        public static Vector3 TransformInDirection(this Quaternion childRotation, Vector3 parentLossyScale, Vector3 childLocalPos)
        {
            return childRotation * Vector3.Scale(childLocalPos, new Vector3(parentLossyScale.x > 0 ? 1 : -1, parentLossyScale.y > 0 ? 1 : -1, parentLossyScale.y > 0 ? 1 : -1));
        }

        public static Vector3 InverseTransformVector(this Quaternion tRotation, Vector3 tLossyScale, Vector3 worldPos)
        {
            worldPos = Quaternion.Inverse(tRotation) * worldPos;
            return new Vector3(worldPos.x / tLossyScale.x, worldPos.y / tLossyScale.y, worldPos.z / tLossyScale.z);
        }


        /// <summary> Instance for 2D Axis limit calculations </summary>
        private static Plane axis2DProjection;

        /// <summary>
        /// Calculating offset (currentPos -= Axis2DLimit...) to prevent object from moving in provided axis
        /// </summary>
        /// <param name="axis">1 is X   2 is Y   3 is Z</param>
        public static Vector3 VAxis2DLimit(this Transform parent, Vector3 parentPos, Vector3 childPos, int axis = 3)
        {
            if (axis == 3)  // Z is depth
                axis2DProjection.SetNormalAndPosition(parent.forward, parentPos);
            else
            if (axis == 2)   // Y
                axis2DProjection.SetNormalAndPosition(parent.up, parentPos);
            else             // X is depth
                axis2DProjection.SetNormalAndPosition(parent.right, parentPos);

            return axis2DProjection.normal * axis2DProjection.GetDistanceToPoint(childPos);
        }

        #endregion


        #region Just Rotations related

        /// <summary>
        /// Locating world rotation in local space of parent transform
        /// </summary>
        public static Quaternion QToLocal(this Quaternion parentRotation, Quaternion worldRotation)
        {
            return Quaternion.Inverse(parentRotation) * worldRotation;
        }

        /// <summary>
        /// Locating local rotation of child local space to world
        /// </summary>
        public static Quaternion QToWorld(this Quaternion parentRotation, Quaternion localRotation)
        {
            return parentRotation * localRotation;
        }

        /// <summary>
        /// Offsetting rotation of child transform with defined axis orientation
        /// </summary>
        public static Quaternion QRotateChild(this Quaternion offset, Quaternion parentRot, Quaternion childLocalRot)
        {
            return (offset * parentRot) * childLocalRot;
        }

        public static Quaternion ClampRotation(this Vector3 current, Vector3 bounds)
        {
            WrapVector(current);

            if (current.x < -bounds.x) current.x = -bounds.x; else if (current.x > bounds.x) current.x = bounds.x;
            if (current.y < -bounds.y) current.y = -bounds.y; else if (current.y > bounds.y) current.y = bounds.y;
            if (current.z < -bounds.z) current.z = -bounds.z; else if (current.z > bounds.z) current.z = bounds.z;

            return Quaternion.Euler(current);
        }



        /// <summary>
        /// For use with rigidbody.angularVelocity (Remember to set "rigidbody.maxAngularVelocity" higher)
        /// </summary>
        /// <param name="deltaRotation"> Create with [TargetRotation] * Quaternion.Inverse([CurrentRotation]) </param>
        /// <returns> Multiply this value by rotation speed parameter like QToAngularVelocity(deltaRot) * RotationSpeed </returns>
        public static Vector3 QToAngularVelocity(this Quaternion deltaRotation, bool fix = false)
        {
            float angle; Vector3 axis;
            deltaRotation.ToAngleAxis(out angle, out axis);
            if (angle != 0f) angle = Mathf.DeltaAngle(0f, angle);
            else return Vector3.zero;

            axis = axis * (angle * Mathf.Deg2Rad);
            if (fix) axis /= Time.fixedDeltaTime;

#if UNITY_2018_4_OR_NEWER
            if (axis.x is float.NaN) return Vector3.zero;
            if (axis.y is float.NaN) return Vector3.zero;
            if (axis.z is float.NaN) return Vector3.zero;
#endif

            return axis;
        }

        public static Vector3 QToAngularVelocity(this Quaternion currentRotation, Quaternion targetRotation, bool fix = false)
        {
            return QToAngularVelocity(targetRotation * Quaternion.Inverse(currentRotation), fix);
        }


        public static bool QIsZero(this Quaternion rot)
        {
            if (rot.x != 0f) return false; if (rot.y != 0f) return false; if (rot.z != 0f) return false; return true;
        }

        public static bool QIsSame(this Quaternion rot1, Quaternion rot2)
        {
            if (rot1.x != rot2.x) return false; if (rot1.y != rot2.y) return false; if (rot1.z != rot2.z) return false; if (rot1.w != rot2.w) return false; return true;
        }


        /// <summary> Wrapping angle (clamping in +- 360) </summary>
        public static float WrapAngle(float angle)
        {
            angle %= 360;
            if (angle > 180) return angle - 360;
            return angle;
        }

        public static Vector3 WrapVector(Vector3 angles)
        { return new Vector3(WrapAngle(angles.x), WrapAngle(angles.y), WrapAngle(angles.z)); }

        /// <summary> Unwrapping angle </summary>
        public static float UnwrapAngle(float angle)
        {
            if (angle >= 0) return angle;
            angle = -angle % 360;
            return 360 - angle;
        }

        public static Vector3 UnwrapVector(Vector3 angles)
        { return new Vector3(UnwrapAngle(angles.x), UnwrapAngle(angles.y), UnwrapAngle(angles.z)); }


#endregion


#region Animation Related


        public static Quaternion SmoothDampRotation(this Quaternion current, Quaternion target, ref Quaternion velocityRef, float duration, float delta)
        {
            return SmoothDampRotation(current, target, ref velocityRef, duration, Mathf.Infinity, delta);
        }

        public static Quaternion SmoothDampRotation(this Quaternion current, Quaternion target, ref Quaternion velocityRef, float duration, float maxSpeed, float delta)
        {
            float dot = Quaternion.Dot(current, target);
            float sign = dot > 0f ? 1f : -1f;
            target.x *= sign;
            target.y *= sign;
            target.z *= sign;
            target.w *= sign;

            Vector4 smoothVal = new Vector4(
                Mathf.SmoothDamp(current.x, target.x, ref velocityRef.x, duration, maxSpeed, delta),
                Mathf.SmoothDamp(current.y, target.y, ref velocityRef.y, duration, maxSpeed, delta),
                Mathf.SmoothDamp(current.z, target.z, ref velocityRef.z, duration, maxSpeed, delta),
                Mathf.SmoothDamp(current.w, target.w, ref velocityRef.w, duration, maxSpeed, delta)).normalized;

            Vector4 correction = Vector4.Project(new Vector4(velocityRef.x, velocityRef.y, velocityRef.z, velocityRef.w), smoothVal);
            velocityRef.x -= correction.x;
            velocityRef.y -= correction.y;
            velocityRef.z -= correction.z;
            velocityRef.w -= correction.w;

            return new Quaternion(smoothVal.x, smoothVal.y, smoothVal.z, smoothVal.w);
        }


#endregion



#region Helper Maths


        public static bool SameDirection(this float a, float b)
        {
            return (a > 0 && b > 0) || (a < 0f && b < 0f);
        }


        /// <summary>
        /// Using Halton Sequence to choose propabilistic coords for example for raycasts
        /// !!!! baseV must be greater than one > 1
        /// </summary>
        public static float PointDisperse01(int index, int baseV = 2)
        {
            float sum = 0f; float functionV = 1f / baseV; int i = index;
            while (i > 0) { sum += functionV * (i % baseV); i = Mathf.FloorToInt(i / baseV); functionV /= baseV; }
            return sum;
        }

        public static float PointDisperse(int index, int baseV = 2)
        {
            float sum = 0f; float functionV = 1f / baseV; int i = index;
            while (i > 0) { sum += functionV * (i % baseV); i = Mathf.FloorToInt(i / baseV); functionV /= baseV; }
            return (sum - 0.5f);
        }


#endregion



#region Matrixes


        /// <summary>
        /// Getting scalling axis lossy scale value if object changes it's size by transform scale
        /// </summary>
        public static float GetScaler(this Transform transform)
        {
            float scaler;
            if (transform.lossyScale.x > transform.lossyScale.y)
            {
                if (transform.lossyScale.y > transform.lossyScale.z)
                    scaler = transform.lossyScale.y;
                else
                    scaler = transform.lossyScale.z;
            }
            else
                scaler = transform.lossyScale.x;

            return scaler;
        }

        /// <summary>
        /// Extracting position from Matrix
        /// </summary>
        public static Vector3 PosFromMatrix(this Matrix4x4 m)
        {
            return m.GetColumn(3);
        }

        /// <summary>
        /// Extracting rotation from Matrix
        /// </summary>
        public static Quaternion RotFromMatrix(this Matrix4x4 m)
        {
            return Quaternion.LookRotation(m.GetColumn(2), m.GetColumn(1));
        }

        /// <summary>
        /// Extracting scale from Matrix
        /// </summary>
        public static Vector3 ScaleFromMatrix(this Matrix4x4 m)
        {
            return new Vector3
            (
                m.GetColumn(0).magnitude,
                m.GetColumn(1).magnitude,
                m.GetColumn(2).magnitude
            );
        }


#if UNITY_2018_4_OR_NEWER
        public static Bounds RotateBoundsByMatrix(this Bounds b, Quaternion rotation)
        {
            if (QIsZero(rotation)) return b;

            Matrix4x4 rot = Matrix4x4.Rotate(rotation);

            Bounds newB = new Bounds();
            Vector3 fr1 = rot.MultiplyPoint(new Vector3(b.max.x, b.min.y, b.max.z));
            Vector3 br1 = rot.MultiplyPoint(new Vector3(b.max.x, b.min.y, b.min.z));
            Vector3 bl1 = rot.MultiplyPoint(new Vector3(b.min.x, b.min.y, b.min.z));
            Vector3 fl1 = rot.MultiplyPoint(new Vector3(b.min.x, b.min.y, b.max.z));
            newB.Encapsulate(fr1);
            newB.Encapsulate(br1);
            newB.Encapsulate(bl1);
            newB.Encapsulate(fl1);

            Vector3 fr = rot.MultiplyPoint(new Vector3(b.max.x, b.max.y, b.max.z));
            Vector3 br = rot.MultiplyPoint(new Vector3(b.max.x, b.max.y, b.min.z));
            Vector3 bl = rot.MultiplyPoint(new Vector3(b.min.x, b.max.y, b.min.z));
            Vector3 fl = rot.MultiplyPoint(new Vector3(b.min.x, b.max.y, b.max.z));
            newB.Encapsulate(fr);
            newB.Encapsulate(br);
            newB.Encapsulate(bl);
            newB.Encapsulate(fl);

            return newB;
        }
#else
        public static Bounds RotateBoundsByMatrix(this Bounds b, Quaternion rotation)
        {
            if (QIsZero(rotation)) return b;

            Matrix4x4 rot = Matrix4x4.Rotate(rotation);

            Bounds newB = new Bounds();
            Vector3 fr1 = rot.MultiplyPoint(new Vector3(b.max.x, b.min.y, b.max.z));
            Vector3 br1 = rot.MultiplyPoint(new Vector3(b.max.x, b.min.y, b.min.z));
            Vector3 bl1 = rot.MultiplyPoint(new Vector3(b.min.x, b.min.y, b.min.z));
            Vector3 fl1 = rot.MultiplyPoint(new Vector3(b.min.x, b.min.y, b.max.z));
            newB.Encapsulate(fr1);
            newB.Encapsulate(br1);
            newB.Encapsulate(bl1);
            newB.Encapsulate(fl1);

            Vector3 fr = rot.MultiplyPoint(new Vector3(b.max.x, b.max.y, b.max.z));
            Vector3 br = rot.MultiplyPoint(new Vector3(b.max.x, b.max.y, b.min.z));
            Vector3 bl = rot.MultiplyPoint(new Vector3(b.min.x, b.max.y, b.min.z));
            Vector3 fl = rot.MultiplyPoint(new Vector3(b.min.x, b.max.y, b.max.z));
            newB.Encapsulate(fr);
            newB.Encapsulate(br);
            newB.Encapsulate(bl);
            newB.Encapsulate(fl);

            return newB;
        }
#endif

        /// <summary>
        /// Roatate by 90, not precise
        /// </summary>
        public static Bounds RotateLocalBounds(this Bounds b, Quaternion rotation)
        {
            float angle = Quaternion.Angle(rotation, Quaternion.identity);

            if (angle > 45 && angle < 135) b.size = new Vector3(b.size.z, b.size.y, b.size.x);
            if (angle < 315 && angle > 225) b.size = new Vector3(b.size.z, b.size.y, b.size.x);

            return b;
        }



#endregion


        public static int[] GetLayermaskValues(int mask, int optionsCount)
        {
            System.Collections.Generic.List<int> masks = new System.Collections.Generic.List<int>();

            for (int i = 0; i < optionsCount; i++)
            {
                int layer = 1 << i;
                if ((mask & layer) != 0) masks.Add(i);
            }

            return masks.ToArray();
        }


#region Physical Materials Stuff

        public static PhysicMaterial PMSliding
        {
            get
            {
                if (_slidingMat) return _slidingMat;
                else
                {
                    _slidingMat = new PhysicMaterial("Slide");
                    _slidingMat.frictionCombine = PhysicMaterialCombine.Minimum;
                    _slidingMat.dynamicFriction = 0f;
                    _slidingMat.staticFriction = 0f;
                    return _slidingMat;
                }
            }
        }

        private static PhysicMaterial _slidingMat;
        public static PhysicMaterial PMFrict
        {
            get
            {
                if (_frictMat) return _frictMat;
                else
                {
                    _frictMat = new PhysicMaterial("Friction");
                    _frictMat.frictionCombine = PhysicMaterialCombine.Maximum;
                    _frictMat.dynamicFriction = 10f;
                    _frictMat.staticFriction = 10f;
                    return _frictMat;
                }
            }
        }

        private static PhysicMaterial _frictMat;


        public static PhysicsMaterial2D PMSliding2D
        {
            get
            {
                if (_slidingMat2D) return _slidingMat2D;
                else
                {
                    _slidingMat2D = new PhysicsMaterial2D("Slide2D");
                    _slidingMat2D.friction = 0f;
                    return _slidingMat2D;
                }
            }
        }

        private static PhysicsMaterial2D _slidingMat2D;

        public static PhysicsMaterial2D PMFrict2D
        {
            get
            {
                if (_frictMat2D) return _frictMat2D;
                else
                {
                    _frictMat2D = new PhysicsMaterial2D("Friction2D");
                    _frictMat2D.friction = 5f;
                    return _frictMat2D;
                }
            }
        }

        private static PhysicsMaterial2D _frictMat2D;

#endregion

    }
}