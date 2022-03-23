using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterControllerThirdPersonController : MonoBehaviour
{

    public CharacterController controller; //character controller component
    public Transform cam; //camera transform

    public float speed = 6; //speed of movement
    public float gravity = -9.81f; //strength of gravity
    public float jumpHeight = 3; //height of jump
    Vector3 velocity;
    bool isGrounded; //is the player grounded

    public Transform groundCheck; //groundcheck object
    public float groundDistance = 0.4f; //sphere cast radius
    public LayerMask groundMask; //what objects are considered the ground

    float turnSmoothVelocity;
    public float turnSmoothTime = 0.1f; //smooth turning

    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    // Update is called once per frame
    void Update()
    {
        //isGrounded = true if the player is touching the ground
        isGrounded = Physics.CheckSphere(groundCheck.position, groundDistance, groundMask);

        //reset gravity if grounded
        if (isGrounded && velocity.y < 0)
        {
            controller.slopeLimit = 100f;
            velocity.y = -2f;
        }

        //jump when jump button is pressed whilst on the ground
        if (Input.GetButtonDown("Jump") && isGrounded)
        {
            controller.slopeLimit = 45f;
            velocity.y = Mathf.Sqrt(jumpHeight * -2 * gravity);
        }

        //apply gravity
        velocity.y += gravity * Time.deltaTime;
        controller.Move(velocity * Time.deltaTime);

        //get input for movement
        float xInput = Input.GetAxisRaw("Horizontal");
        float zInput = Input.GetAxisRaw("Vertical");
        Vector3 direction = new Vector3(xInput, 0f, zInput).normalized;

        if (direction.magnitude >= 0.1f)
        {
            float targetAngle = Mathf.Atan2(direction.x, direction.z) * Mathf.Rad2Deg + cam.eulerAngles.y;
            float angle = Mathf.SmoothDampAngle(transform.eulerAngles.y, targetAngle, ref turnSmoothVelocity, turnSmoothTime);
            transform.rotation = Quaternion.Euler(0f, angle, 0f);

            Vector3 moveDir = Quaternion.Euler(0f, targetAngle, 0f) * Vector3.forward;
            controller.Move(moveDir.normalized * speed * Time.deltaTime);
        }
    }
}