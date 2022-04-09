using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatScroller : MonoBehaviour
{
    public float scrollSpeed;
    public List<GameObject> children;

    void Start()
    {
        foreach (Transform child in transform)
        {
            children.Add(child.gameObject);
        }
    }

    // Update is called once per frame
    void Update()
    {
        transform.Translate(Vector3.left * scrollSpeed * Time.deltaTime);

        if(children.Count == 0)
        {
            Destroy(gameObject);
        }
    }

    public void RemoveBeat()
    {
        children.RemoveAt(children.Count - 1);
    }
}