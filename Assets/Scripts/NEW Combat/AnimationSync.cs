using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationSync : MonoBehaviour
{
    public AnimationClip anim;
    public Animator animator;
    public float tempo;
    // Start is called before the first frame update
    void Start()
    {
        InvokeRepeating("PlayAnim", 0.5f, tempo);
    }

    void PlayAnim()
    {
        if(!Conductor.instance.songFinished)
        {
            animator.SetTrigger("Pulse");
        }
    }
}
