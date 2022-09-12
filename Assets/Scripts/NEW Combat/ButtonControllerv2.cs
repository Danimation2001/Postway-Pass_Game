using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class ButtonControllerv2 : MonoBehaviour
{
    public Animator anim;
    public int health = 100;
    public int maxHealth = 100;
    public InputAction up, down, left, right;

    void OnEnable()
    {
        up.Enable();
        down.Enable();
        left.Enable();
        right.Enable();

        up.performed += Up;
        down.performed += Down;
        left.performed += Left;
        right.performed += Right;
    }

    void OnDisable()
    {
        DisableInput();
    }

    void DisableInput()
    {
        up.Disable();
        down.Disable();
        left.Disable();
        right.Disable();
    }

    void Start()
    {
        health = maxHealth;
    }
    
    // Update is called once per frame
    void Update()
    {
        //RhythmManager.instance.healthSlider.value = health;

        if (health <= 0)
        {
            DisableInput();
        }
    }

    public void TakeDamage(int amount)
    {
        health -= amount;

        if (health > maxHealth)
        {
            health = maxHealth;
        }

        if (health <= 0)
        {
            GameManager.Instance.GameOver();
        }

    }

    void Up(InputAction.CallbackContext context)
    {
        anim.SetTrigger("Up");
    }

    void Down(InputAction.CallbackContext context)
    {
        anim.SetTrigger("Down");
    }

    void Left(InputAction.CallbackContext context)
    {
        anim.SetTrigger("Left");
    }

    void Right(InputAction.CallbackContext context)
    {
        anim.SetTrigger("Right");
    }
}
