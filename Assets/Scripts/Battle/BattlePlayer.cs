using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class BattlePlayer : MonoBehaviour
{
    public int maxHealth = 100;
    public int currentHealth;
    public int damage;
    public int heal;

    public int attackCost;
    public int buffCost;
    public int debuffCost;

    public int damageMultiplier;
    public bool damageBuffed;
    public bool enemyWeak;

    // Start is called before the first frame update
    void Start()
    {
        currentHealth = maxHealth;
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void CastAttack()
    {
        currentHealth -= attackCost;
    }

    public void CastBuff()
    {
        currentHealth -= buffCost;
        damageBuffed = true;
    }

    public void CastDebuff()
    {
        currentHealth -= debuffCost;
        enemyWeak = true;
    }

    public bool TakeDamage(int _damage)
    {
        currentHealth -= _damage;
        if (currentHealth <= 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}