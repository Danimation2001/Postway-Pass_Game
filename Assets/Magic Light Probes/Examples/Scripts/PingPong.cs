#if UNITY_EDITOR
using UnityEngine;

namespace MagicLightProbes
{
    public class PingPong : MonoBehaviour
    {
        public enum Direction
        {
            TopDown,
            LeftRight,
            ForwarBackward
        }

        public Direction direction;
        public float distance;
        public float speed;
        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            switch (direction)
            {
                case Direction.ForwarBackward:
                    transform.localPosition = new Vector3(0, 0, Mathf.PingPong(Time.time, distance));
                    break;
                case Direction.LeftRight:
                    transform.localPosition = new Vector3(Mathf.PingPong(Time.time, distance), 0, 0);
                    break;
                case Direction.TopDown:
                    transform.localPosition = new Vector3(0, Mathf.PingPong(Time.time, distance), 0);
                    break;
            }
        }
    }
}
#endif
