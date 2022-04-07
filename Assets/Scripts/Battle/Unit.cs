using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Unit : MonoBehaviour
{
    public string unitName;
    public int damage;
    public int maxHealth;
    public int currentHealth;
    public GameObject beats;

    public bool TakeDamage(int _dmg)
    {
        currentHealth -= _dmg;

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
