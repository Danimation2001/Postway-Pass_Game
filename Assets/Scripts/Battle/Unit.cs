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

        if (currentHealth <= 0) //if the enemy ran out of health
        {
            return true; //they are dead
        }
        else
        {
            anim.Play("Hurt", -1, 0);
            return false; // they are not dead
        }
    }
}