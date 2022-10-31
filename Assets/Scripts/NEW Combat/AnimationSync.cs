using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationSync : MonoBehaviour
{
    Animator animator;
    public float tempo;
    public float delay;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        InvokeRepeating("PlayAnim", delay, tempo);
    }

    void PlayAnim()
    {
        if(!Conductor.instance.songFinished && !GameManager.Instance.gameOver)
        {
            animator.Play("Bounce", -1, 0f);
        }
    }

}
