using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class BattlePlayer : MonoBehaviour
{
    public int maxHealth = 100;
    public int currentHealth;
    public int damage;
    public HealthBar healthBar;
    public InputAction takeDamage;
    public InputAction hitNote;

    void OnEnable()
    {
        takeDamage.Enable();

        takeDamage.performed += context => TakeDamage(20);
    }

    void OnDisable()
    {
        takeDamage.Disable();
    }

    // Start is called before the first frame update
    void Start()
    {
        currentHealth = maxHealth;
    }

    // Update is called once per frame
    void Update()
    {

    }

    void TakeDamage(int _damage)
    {   
        currentHealth -= _damage;
        healthBar.SetHealth(currentHealth);
    }
}
