using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations;

public class FrozenKey : MonoBehaviour
{
    public bool canBeCollected;
    //public GameObject key; 

    Animator _anim;

    //[Header ("PLACEHOLDER. REMOVE WHEN FINAL ASSET IS READY!")]
    //public Material onMat, offMat;

    // Start is called before the first frame update
    void Start()
    {
        _anim = GetComponent<Animator>();

        if (GameManager.Instance.hasFrozenKey)
            Destroy(gameObject);
    }

    // Update is called once per frame
    void Update()
    {
       
    }

    IEnumerator CollectKey()
    {
        // ADD ANIMATIONS AND EFFECTS
        _anim.Play("KeyCollect");
        yield return new WaitForSeconds(4f);
        gameObject.SetActive(false);
        GameManager.Instance.hasFrozenKey = true;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player" && canBeCollected)
        {
            StartCoroutine(CollectKey());
        }
    }

}
