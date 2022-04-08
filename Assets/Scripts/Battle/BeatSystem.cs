using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class BeatSystem : MonoBehaviour
{
    public float scrollSpeed;
    public GameObject scroller;
    public GameObject striker;
    public InputAction strikeNote;

    void OnEnable()
    {
        strikeNote.Enable();
        strikeNote.performed += StrikeNote;
    }

    void OnDisable()
    {
        strikeNote.Disable();
    }

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        Scroll();
    }

    void Scroll()
    {
        scroller.transform.Translate(Vector3.left * scrollSpeed * Time.deltaTime);
    }

    void StrikeNote(InputAction.CallbackContext context)
    {
        striker.GetComponent<Animator>().Play("Strike");
    }
}
