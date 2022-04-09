using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Unit : MonoBehaviour
{
    public string unitName;
    public int damage;
    public int maxHealth;
    public int currentHealth;
    public List<GameObject> beatPatterns;
    public Animator anim;

    public bool TakeDamage(int _dmg)
    {
        currentHealth -= _dmg;
        anim.Play("Hurt");

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