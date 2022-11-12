using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations;

public class IceBlock : MonoBehaviour
{
    public bool iceMelting;
    public bool iceMelted;
    Animator _anim;

    void Start()
    {
        if(GameManager.Instance.hasFrozenKey)
        {
            gameObject.SetActive(false);
        }
        _anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator MeltIce()
    {
        _anim.Play("IceMelt");
        yield return new WaitForSeconds (1.5f);
        iceMelted = true;
        gameObject.SetActive(false);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player" && iceMelting)
        {
            StartCoroutine(MeltIce());
        }
    }
}

