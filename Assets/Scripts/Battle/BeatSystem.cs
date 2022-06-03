using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class BeatSystem : MonoBehaviour
{
    public GameObject fill;
    public BattleSystem battleSystem;
    public Transform scrollerSpawn;
    public GameObject striker;
    public InputAction strikeNote;
    public List<GameObject> attackPatterns;
    public List<GameObject> enemyPatterns;
    public GameObject currentPattern;
    BeatScroller _scroller;
    public GameObject hittableNote;
    public Animator playerAnim;
    public AudioSource soundFX;


    void OnEnable()
    {
        strikeNote.Enable();
        strikeNote.performed += StrikeNote;
    }

    void OnDisable()
    {
        strikeNote.Disable();
    }

    // Start is called before the first frame update
    void Start()
    {
        enemyPatterns = battleSystem.currentEnemy.GetComponent<Unit>().beatPatterns; // Get the enemy patterns from the current unit
    }

    // Update is called once per frame
    void Update()
    {
        if (scrollerSpawn.childCount == 0)
        {
            battleSystem.beatOnScreen = false;
            strikeNote.Disable();
        }

        if (_scroller == null && scrollerSpawn.childCount > 0)
        {
            _scroller = scrollerSpawn.GetComponentInChildren<BeatScroller>();
        }
    }

    public void StartPattern(BattleState _state) // Spawns in the beat pattern for that turn
    {
        strikeNote.Enable();

        if (_state == BattleState.ATTACK)
        {
            fill.GetComponent<SpriteRenderer>().color = Color.yellow;
            currentPattern = Instantiate(attackPatterns[Random.Range(0, attackPatterns.Count)], scrollerSpawn); // Picks a random pattern from a list of possible attack patterns
        }
        else if (_state == BattleState.DEFENSE)
        {
            fill.GetComponent<SpriteRenderer>().color = Color.magenta;
            currentPattern = Instantiate(enemyPatterns[Random.Range(0, enemyPatterns.Count)], scrollerSpawn); // Picks a random pattern from a list of possible defense patterns
        }
        battleSystem.beatOnScreen = true;
    }

    void StrikeNote(InputAction.CallbackContext context) // Plays the striking animation and controls what happens when the button is pressed
    {
        BeatStriker _striker = striker.GetComponent<BeatStriker>();
        striker.GetComponent<Animator>().Play("Strike");
        if (_striker.canHitNote) // if you hit the note
        {
            _scroller.RemoveBeat();
            Destroy(hittableNote);
            soundFX.Play();
           
            if (battleSystem.state == BattleState.ATTACK) // Damage the enemy
            {
                playerAnim.Play("Attack", -1, 0f);

                if (battleSystem.player.damageBuffed)
                {
                    battleSystem.enemyDead = battleSystem.currentEnemy.GetComponent<Unit>().TakeDamage(battleSystem.player.damage * battleSystem.player.damageMultiplier);
                }
                else
                {
                    battleSystem.enemyDead = battleSystem.currentEnemy.GetComponent<Unit>().TakeDamage(battleSystem.player.damage);
                }
                battleSystem.hud.UpdateEnemyHP(battleSystem.currentEnemy.GetComponent<Unit>().currentHealth);
            }

            else if (battleSystem.state == BattleState.DEFENSE) // block attacks
            {
                playerAnim.Play("Block", -1, 0f);
                battleSystem.currentEnemy.GetComponentInChildren<Animator>().Play("Attack", -1, 0);
                
                if (battleSystem.player.enemyWeak)
                {
                    battleSystem.playerDead = battleSystem.player.TakeDamage(battleSystem.currentEnemy.GetComponent<Unit>().damage / battleSystem.player.damageMultiplier / battleSystem.player.blockStrength);
                }
                else
                {
                    battleSystem.playerDead = battleSystem.player.TakeDamage(battleSystem.currentEnemy.GetComponent<Unit>().damage / battleSystem.player.blockStrength);
                }
                battleSystem.hud.UpdatePlayerHP(battleSystem.player.currentHealth);
            }
        }
        // else if(_striker.canHitHoldNote)
        // {

        // }
        else // Damage the player if they spam the button
        {
            playerAnim.Play("Hurt", -1, 0f);
            battleSystem.currentEnemy.GetComponentInChildren<Animator>().Play("Attack", -1, 0);

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