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

    public int potionStrength;

    public int attackCost;
    public int buffCost;
    public int debuffCost;

    public int damageMultiplier;
    public bool damageBuffed;
    public bool enemyWeak;

    public Animator playerAnim;

    // Start is called before the first frame update
    void Start()
    {
        currentHealth = maxHealth;
    }

    public void CastAttack() //pay the cost of casting the attack
    {
        currentHealth -= attackCost;
    }

    public void CastBuff() //pay the cost of casting the buff
    {
        currentHealth -= buffCost;
        damageBuffed = true;
    }

    public void CastDebuff() //pay the cost of casting the debuff
    {
        currentHealth -= debuffCost;
        enemyWeak = true;
    }

    public bool TakeDamage(int _damage) // take damage
    {
        currentHealth -= _damage;
        if (currentHealth <= 0)
        {
            return true;
        }
        else
        {
            playerAnim.Play("Hurt", -1, 0f);
            return false;
        }
    }
}