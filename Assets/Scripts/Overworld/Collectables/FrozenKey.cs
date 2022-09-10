using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FrozenKey : MonoBehaviour
{
    public bool canBeCollected;

    [Header ("PLACEHOLDER. REMOVE WHEN FINAL ASSET IS READY!")]
    public Material onMat, offMat;

    // Start is called before the first frame update
    void Start()
    {
        if (GameManager.Instance.hasKey)
            Destroy(gameObject);
    }

    // Update is called once per frame
    void Update()
    {
        // TEMPORARY. DON'T NEED WITH FINAL ASSET.
        if (canBeCollected)
        {
            GetComponentInChildren<MeshRenderer>().material = onMat;
        }
    }

    IEnumerator CollectKey()
    {
        // ADD ANIMATIONS AND EFFECTS
        //_anim.Play("Collect");
        yield return new WaitForSeconds(0f);
        gameObject.SetActive(false);
        GameManager.Instance.hasKey = true;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player" && canBeCollected)
        {
            StartCoroutine(CollectKey());
        }
    }

}
