using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleporter : MonoBehaviour
{
    public Transform destination;
    GameObject _player;

    IEnumerator Teleport()
    {
        // fade out and disable control
        SceneLoader.Instance.transition.Play("Fade Game Out");
        _player.GetComponent<Rigidbody>().isKinematic = true;
        yield return new WaitForSeconds(1);
        _player.GetComponent<RBController>().enabled = false;

        // teleport
        _player.transform.position = destination.position;
        yield return new WaitForSeconds(0.5f);

        //fade in and enable control
        SceneLoader.Instance.transition.Play("Fade Game In");
        _player.GetComponent<RBController>().enabled = true;
        _player.GetComponent<Rigidbody>().isKinematic = false;
        yield return new WaitForSeconds(1);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            _player = other.transform.parent.gameObject;
            StartCoroutine(Teleport());
        }
    }
}
