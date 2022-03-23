using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RigidbodyThirdPersonController : MonoBehaviour
{

    Rigidbody _rigidbody; //rigidbody component
    Transform cam; //camera transform

    [SerializeField] float _moveSpeed = 6f; //speed of movement
    float _groundMultiplier = 100f;
    [SerializeField] float _airMultiplier;
    [SerializeField] float _jumpStrength = 3f; //height of jump
    [SerializeField] float _rotationSmoothing = 360f;
    float _normalDrag = 10f;


    bool isGrounded; //is the player grounded

    public Transform groundCheck; //groundcheck object
    float _groundDistance = 0.1f; //sphere cast radius
    public LayerMask groundMask; //what objects are considered the ground

    Vector3 _movement;
    bool _pressedJump;
    Quaternion _targetAngle;

    void Awake()
    {
        Cursor.lockState = CursorLockMode.Locked;
        cam = Camera.main.transform;
        _rigidbody = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        ReadInput();

        //movement direction is based on camera rotation (forward is always forward relative to where the player is looking)
        _movement = cam.TransformDirection(_movement);
        _movement.y = 0f;

        _targetAngle = Quaternion.LookRotation(_movement);
        _targetAngle = Quaternion.RotateTowards(transform.rotation, _targetAngle, _rotationSmoothing * Time.deltaTime);

        //isGrounded = true if the player is touching the ground
        isGrounded = Physics.CheckSphere(groundCheck.position, _groundDistance, groundMask);

        if (isGrounded)
        {
            _rigidbody.drag = _normalDrag;
        }
        else
        {
            _rigidbody.drag = 0f;
        }
    }

    void ReadInput()
    {
        //get input for movement
        _movement = new Vector3(Input.GetAxisRaw("Horizontal"), 0f, Input.GetAxisRaw("Vertical")).normalized;
        _movement *= _moveSpeed;

        //jump when jump button is pressed whilst on the ground
        if (Input.GetButtonDown("Jump") && isGrounded)
        {
            _pressedJump = true;
        }
    }

    //use for phyisics
    void FixedUpdate()
    {
        Move();
        Jump();
    }

    void Move()
    {
        if (isGrounded)
        {
            _rigidbody.AddForce(_movement * _groundMultiplier, ForceMode.Force);
        }
        else
        {
            _rigidbody.AddForce(_movement * _airMultiplier, ForceMode.Force);
        }

        if (_movement.magnitude > 0f && isGrounded)
        {
            _rigidbody.MoveRotation(_targetAngle);
        }
    }

    void Jump()
    {
        if (_pressedJump)
        {
            _rigidbody.AddForce(Vector3.up * _jumpStrength, ForceMode.Impulse);
            _pressedJump = false;
        }
    }
}