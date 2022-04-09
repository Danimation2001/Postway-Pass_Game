using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MissLine : MonoBehaviour
{
    BeatScroller _scroller;
    public Transform scrollerParent;
    public BattleSystem battleSystem;

    // Update is called once per frame
    void Update()
    {
        if (_scroller == null && scrollerParent.childCount > 0)
        {
            _scroller = scrollerParent.GetComponentInChildren<BeatScroller>();
        }
    }

    void OnTriggerEnter2D(Collider2D other) // if the player missed the note while in defense, damage them
    {
        if (other.tag == "Beat")
        {
            _scroller.RemoveBeat();
            Destroy(other.gameObject);

            if (battleSystem.state == BattleState.DEFENSE)
            {
                battleSystem.currentEnemy.GetComponent<Animator>().Play("Attack");
                if (battleSystem.player.enemyWeak)
                {
                    battleSystem.playerDead = battleSystem.player.TakeDamage(battleSystem.currentEnemy.GetComponent<Unit>().damage / battleSystem.player.damageMultiplier);
                }
                else
                {
                    battleSystem.playerDead = battleSystem.player.TakeDamage(battleSystem.currentEnemy.GetComponent<Unit>().damage);
                }
                battleSystem.hud.UpdatePlayerHP(battleSystem.player.currentHealth);
            }
        }
    }
}