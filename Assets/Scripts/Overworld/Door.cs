using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Animations;
using TMPro;

public class Door : MonoBehaviour
{
    [SerializeField] InputAction _interact;
    [SerializeField] GameObject _interactCanvas;
    [SerializeField] Animator _doorAnim;
    [SerializeField] Transform _playerStart;
    [SerializeField] Transform _playerEnd;
    [SerializeField] GameObject _characterArt;
    public float moveSpeed;
    public float walkHaltTime;

    ConstraintSource _constraintSource;
    GameObject _player;
    Animator _characterAnim;


    void OnEnable()
    {
        _interact.Enable();
        _interact.performed += Interact;
    }

    void OnDisable()
    {
        _interact.Disable();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            _interact.Enable();
            _interactCanvas.GetComponent<Animator>().Play("Fade In");
            _player = other.transform.parent.gameObject;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            _interact.Disable();
            _interactCanvas.GetComponent<Animator>().Play("Fade Out");
            _player = null;
        }
    }

    void Interact(InputAction.CallbackContext context)
    {
        StartCoroutine("OpenDoor");
    }

    IEnumerator OpenDoor()
    {
        DisablePlayerControl();
        _player.transform.position = _playerStart.position;
        _characterArt.SetActive(true);
        _characterAnim.Play("OpenDoor");
        _doorAnim.Play("Open");
        yield return new WaitForSeconds(walkHaltTime);
        StartCoroutine(MoveFromTo(_player.transform, _player.transform.position, _playerEnd.position, moveSpeed));
        yield return new WaitForSeconds(walkHaltTime);
        _characterArt.SetActive(false);
        EnablePlayerControl();

    }

    IEnumerator MoveFromTo(Transform objectTrans, Vector3 a, Vector3 b, float speed)
    {
        float step = (speed / (a - b).magnitude) * Time.fixedDeltaTime;
        float t = 0;
        while (t <= 1.0f)
        {
            t += step;
            objectTrans.position = Vector3.Lerp(a, b, t);
            yield return new WaitForFixedUpdate();
        }
        objectTrans.position = b;
    }

    void DisablePlayerControl()
    {
        GameObject model = GameObject.Find("RB Player/RB Controller/PlayerModel");
        model.SetActive(false);
        _player.GetComponent<Rigidbody>().isKinematic = true;
        _player.GetComponentInChildren<CapsuleCollider>().enabled = false;
        _player.GetComponent<RBController>().enabled = false;
    }

    void EnablePlayerControl()
    {
        GameObject model = GameObject.Find("RB Player/RB Controller/PlayerModel");
        model.SetActive(true);
        _player.GetComponent<Rigidbody>().isKinematic = false;
        _player.GetComponentInChildren<CapsuleCollider>().enabled = true;
        _player.GetComponent<RBController>().enabled = true;
    }

    // Start is called before the first frame update
    void Start()
    {
        _interact.Disable();

        _constraintSource.sourceTransform = Camera.main.transform;
        _constraintSource.weight = 1;
        _characterAnim = _characterArt.GetComponent<Animator>();

        GetComponentInChildren<LookAtConstraint>().AddSource(_constraintSource);
    }

    // Update is called once per frame
    void Update()
    {

    }
}
