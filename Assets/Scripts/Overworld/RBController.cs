using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class RBController : MonoBehaviour
{
    private const float _threshold = 0.01f;

    [Header("Movement")]
    public float maxSpeed = 8;
    public float acceleration = 200;
    public AnimationCurve accelertionFactorFromDot;
    public float maxAccelForce = 150;
    public AnimationCurve maxAccelerationForceFactorFromDot;
    public Vector3 forceScale = new Vector3(1, 0, 1);
    StarterAssetsInputs _input;
    Vector3 _goalVel;

    [Header("Jumping")]
    public int maxJumps = 2;
    public float jumpUpVel = 7.5f;
    public float jumpDuration = 0.6667f;
    bool _isAirborne;
    float _timer;
    int _jumps;

    [Header("Camera")]
    public GameObject cinemachineCameraTarget;
    public float topClamp = 70.0f;
    public float bottomClamp = -30.0f;
    public float cameraAngleOverride = 0.0f;
    public bool lockCameraPosition = false;
    GameObject _mainCamera;
    private float _cinemachineTargetYaw;
    private float _cinemachineTargetPitch;

    [Header("Physics/Spring")]
    public float rideHeight = 1;
    public float rideSpringStrength = 2000;
    public float rideSpringDamper = 100;
    public Vector3 downDir;
    public LayerMask groundMask;
    Rigidbody _RB;
    public float rayLength = 1.5f;
    RaycastHit _rayHit;
    bool _rayDidHit;
    float _uprightJointSpringStrength = 2000;
    float _uprightJointSpringDamper = 30;
    Quaternion _uprightJointTargetRot;
    Vector3 _groundVel;

    [Header("Animation")]
    public Animator animator;
    public float animationTransition;
    float _animationBlend;
    private bool _hasAnimator;
    // animation IDs
    private int _animIDSpeed;
    private int _animIDGrounded;
    private int _animIDJump;
    private int _animIDFreeFall;
    private int _animIDMotionSpeed;

    void Awake()
    {
        if (_mainCamera == null)
        {
            _mainCamera = GameObject.FindGameObjectWithTag("MainCamera");
        }
    }
    void Start()
    {
        _RB = GetComponent<Rigidbody>();
        _input = GetComponent<StarterAssetsInputs>();

        if (animator != null)
        {
            _hasAnimator = true;
        }

        AssignAnimationIDs();
    }

    void Update()
    {
        if (animator != null)
        {
            _hasAnimator = true;
        }

        if (_input.jump && _jumps < maxJumps)
        {
            _jumps++;
            _input.jump = false;
            rayLength = 0f;
            Jump();
        }

        if (_isAirborne)
        {
            _timer += Time.deltaTime;

            // update animator if using character
            if (_hasAnimator)
            {
                animator.SetBool(_animIDGrounded, false);
                if(_RB.velocity.y < 0) animator.SetBool(_animIDFreeFall, true);
                else animator.SetBool(_animIDFreeFall, false);
            }
        }

        if (_timer >= jumpDuration)
        {
            rayLength = 1.5f;
        }
    }

    void FixedUpdate()
    {
        _rayDidHit = Physics.Raycast(transform.position, Vector3.down, out _rayHit, rayLength, groundMask);
        if (_rayDidHit) GroundingSpringPhysics();
        UpdateUprightForce();
        PlayerMovement();
    }

    void LateUpdate()
    {
        CameraRotation();
    }

    private void CameraRotation()
    {
        // if there is an input and camera position is not fixed
        if (_input.look.sqrMagnitude >= _threshold && !lockCameraPosition)
        {
            _cinemachineTargetYaw += _input.look.x * Time.deltaTime;
            _cinemachineTargetPitch += _input.look.y * Time.deltaTime;
        }

        // clamp our rotations so our values are limited 360 degrees
        _cinemachineTargetYaw = ClampAngle(_cinemachineTargetYaw, float.MinValue, float.MaxValue);
        _cinemachineTargetPitch = ClampAngle(_cinemachineTargetPitch, bottomClamp, topClamp);

        // Cinemachine will follow this target
        cinemachineCameraTarget.transform.rotation = Quaternion.Euler(_cinemachineTargetPitch + cameraAngleOverride, _cinemachineTargetYaw, 0.0f);
    }

    private static float ClampAngle(float lfAngle, float lfMin, float lfMax)
    {
        if (lfAngle < -360f) lfAngle += 360f;
        if (lfAngle > 360f) lfAngle -= 360f;
        return Mathf.Clamp(lfAngle, lfMin, lfMax);
    }

    void PlayerMovement()
    {
        float speedFactor = 1f;
        float maxAccelForceFactor = 1f;

        Vector3 inputDirection = new Vector3(_input.move.x, 0.0f, _input.move.y).normalized;
        Vector3 worldMove = CameraRelativeFlatten(inputDirection, Vector3.up);

        if (_input.move != Vector2.zero)
        { 
            _uprightJointTargetRot = Quaternion.LookRotation(worldMove, Vector3.up);
        }

        if (worldMove.magnitude > 1.0f) worldMove.Normalize();
        Vector3 unitGoal = worldMove;
        Vector3 unitVel = _goalVel.normalized;
        float velDot = Vector3.Dot(unitGoal, unitVel);
        float accel = acceleration * accelertionFactorFromDot.Evaluate(velDot);
        Vector3 goalVel = unitGoal * maxSpeed * speedFactor;
        _goalVel = Vector3.MoveTowards(_goalVel, (goalVel) + (_groundVel), accel * Time.fixedDeltaTime);
        Vector3 neededAccel = (_goalVel - _RB.velocity) / Time.fixedDeltaTime;
        float maxAccel = maxAccelForce * maxAccelerationForceFactorFromDot.Evaluate(velDot) * maxAccelForceFactor;
        neededAccel = Vector3.ClampMagnitude(neededAccel, maxAccel);
        _RB.AddForce(Vector3.Scale(neededAccel * _RB.mass, forceScale));
        float inputMagnitude = _input.analogMovement ? _input.move.magnitude : 1f;
        _animationBlend = Mathf.Lerp(_animationBlend, _RB.velocity.magnitude, animationTransition * Time.deltaTime);

        if (_hasAnimator)
        {
            animator.SetFloat(_animIDSpeed, _animationBlend);
            animator.SetFloat(_animIDMotionSpeed, inputMagnitude);
        }
    }

    void Jump()
    {
        if (_hasAnimator)
        {
            animator.SetTrigger(_animIDJump);
        }

        _timer = 0;
        Vector3 verticalVel = _RB.velocity;
        verticalVel.y = jumpUpVel;
        _RB.velocity = verticalVel;
        _isAirborne = true;
    }

    public void GroundingSpringPhysics()
    {
        _isAirborne = false;
        _jumps = 0;
        Vector3 vel = _RB.velocity;
        Vector3 rayDir = transform.TransformDirection(downDir);

        Vector3 otherVel = Vector3.zero;
        Rigidbody hitBody = _rayHit.rigidbody;
        if (hitBody != null)
        {
            otherVel = hitBody.velocity;
            _groundVel = hitBody.GetPointVelocity(_rayHit.point);
        }

        float rayDirVel = Vector3.Dot(rayDir, vel);
        float otherDirVel = Vector3.Dot(rayDir, otherVel);

        float relVel = rayDirVel - otherDirVel;

        float x = _rayHit.distance - rideHeight;

        float springForce = (x * rideSpringStrength) - (relVel * rideSpringDamper);

        //Debug.DrawLine(transform.position, transform.position + (rayDir * springForce), Color.yellow);

        _RB.AddForce(rayDir * springForce);

        if (hitBody != null)
        {
            hitBody.AddForceAtPosition(rayDir * -springForce, _rayHit.point);
        }

        // update animator if using character
        if (_hasAnimator)
        {
            animator.SetBool(_animIDGrounded, true);
            animator.SetBool(_animIDFreeFall, false);
        }
    }

    public void UpdateUprightForce()
    {
        Quaternion characterCurrent = transform.rotation;
        Quaternion toGoal = UtilsMath.ShortestRotation(_uprightJointTargetRot, characterCurrent);

        Vector3 rotAxis;
        float rotDegrees;

        toGoal.ToAngleAxis(out rotDegrees, out rotAxis);
        rotAxis.Normalize();

        float rotRadians = rotDegrees * Mathf.Deg2Rad;

        _RB.AddTorque((rotAxis * (rotRadians * _uprightJointSpringStrength)) - (_RB.angularVelocity * _uprightJointSpringDamper));
    }

    Vector3 CameraRelativeFlatten(Vector3 input, Vector3 localUp)
    {
        Transform cam = Camera.main.transform;

        Quaternion flatten = Quaternion.LookRotation(-localUp, cam.forward) * Quaternion.Euler(Vector3.right * -90f);

        return flatten * input;
    }

    private void AssignAnimationIDs()
    {
        _animIDSpeed = Animator.StringToHash("Speed");
        _animIDGrounded = Animator.StringToHash("Grounded");
        _animIDJump = Animator.StringToHash("Jump");
        _animIDFreeFall = Animator.StringToHash("FreeFall");
        _animIDMotionSpeed = Animator.StringToHash("MotionSpeed");
    }
}