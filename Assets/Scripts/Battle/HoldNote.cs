using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HoldNote : MonoBehaviour
{
    public float holdLength;
    public Transform holdBar;
    public GameObject holdStart;
    public GameObject holdEnd;
    public Transform endPos;

    // Start is called before the first frame update
    void Start()
    {
        holdBar.localScale = new Vector3(holdLength, 1, 1);

        holdEnd.transform.position = endPos.position;

        GenerateColliders(holdStart, holdEnd);
    }

    // Update is called once per frame
    void Update()
    {

    }

    void GenerateColliders(GameObject _start, GameObject _end)
    {
        //add colliders
        CircleCollider2D startCollider = _start.AddComponent<CircleCollider2D>();
        CircleCollider2D endCollider = _end.AddComponent<CircleCollider2D>();

        //setup colliders
        startCollider.radius = 0.11f;
        startCollider.isTrigger = true;

        endCollider.radius = 0.11f;
        endCollider.isTrigger = true;
    }
}