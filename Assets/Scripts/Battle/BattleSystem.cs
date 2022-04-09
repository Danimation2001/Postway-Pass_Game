using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum BattleState { START, ATTACK, DEFENSE, WON, LOST }

public class BattleSystem : MonoBehaviour
{
    public GameObject enemyPrefab;
    public BeatSystem beatSystem;
    public Transform spawnLocation;
    public BattleState state;
    private Unit _enemyUnit;
    public bool enemyDead;
    public bool playerDead;
    public BattlePlayer player;
    public BattleHUD hud;
    public float entryTime;
    public bool beatOnScreen;
    public GameObject currentEnemy;

    // Start is called before the first frame update
    void Start()
    {
        state = BattleState.START;
        hud.UpdatePhase(state);
        StartCoroutine(SetupBattle());
    }

    IEnumerator SetupBattle()
    {
        currentEnemy = Instantiate(enemyPrefab, spawnLocation); // Spawn the enemy
        _enemyUnit = currentEnemy.GetComponent<Unit>(); // Get the unit script
        // Set up HUDs
        hud.SetEnemyHUD(_enemyUnit);
        hud.SetPlayerHUD(player);

        yield return new WaitForSeconds(entryTime); // Wait for the animation to play

        state = BattleState.ATTACK;
        hud.UpdatePhase(state);
        PlayerTurn();
    }

    void PlayerTurn()
    {

    }

    IEnumerator EnemyTurn()
    {
        hud.phaseText.GetComponentInParent<Animator>().Play("Slide Up");
        yield return new WaitForSeconds(1f);
        beatSystem.GetComponent<Animator>().Play("Slide Down");
        beatSystem.StartPattern(state);

        while (beatOnScreen && !playerDead) // wait until beats are finished
        {
            yield return null;
        }

        yield return new WaitForSeconds(1f);
        beatSystem.GetComponent<Animator>().Play("Slide Up");

        if (player.enemyWeak) // if the enemy was weakened this turn, turn off the debuff at the end of the turn
        {
            player.enemyWeak = false;
        }

        //check if player died
        if (playerDead)
        {
            //end battle
            Destroy(beatSystem.currentPattern);
            state = BattleState.LOST;
            EndBattle();
        }
        else
        {
            //player's turn
            yield return new WaitForSeconds(1f);
            state = BattleState.ATTACK;
            hud.UpdatePhase(state);
            yield return new WaitForSeconds(1f);
            PlayerTurn();
        }
    }

    public void OnAttackButton()
    {
        if (state != BattleState.ATTACK)
        {
            return;
        }
        StartCoroutine(PlayerAttack());
    }

    IEnumerator PlayerAttack()
    {
        hud.attackButtons.GetComponent<Animator>().Play("Slide Left");
        hud.phaseText.GetComponentInParent<Animator>().Play("Slide Up");
        beatSystem.GetComponent<Animator>().Play("Slide Down");
        beatSystem.StartPattern(state);
        player.CastAttack();
        hud.UpdatePlayerHP(player.currentHealth);

        while (beatOnScreen && !enemyDead && !playerDead) // wait until beats are finished
        {
            yield return null;
        }

        yield return new WaitForSeconds(1f);
        beatSystem.GetComponent<Animator>().Play("Slide Up");

        if (player.damageBuffed) // if the player was buffed this turn, turn off the buff at the end of the turn
        {
            player.damageBuffed = false;
        }

        //check if enemy died
        if (enemyDead)
        {
            //end battle
            Destroy(beatSystem.currentPattern);
            state = BattleState.WON;
            EndBattle();
        }
        //check if player died
        else if (playerDead)
        {
            //end battle
            Destroy(beatSystem.currentPattern);
            state = BattleState.LOST;
            EndBattle();
        }
        else
        {
            //enemy turn
            yield return new WaitForSeconds(1f);
            state = BattleState.DEFENSE;
            hud.UpdatePhase(state);
            yield return new WaitForSeconds(2f);
            StartCoroutine(EnemyTurn());
        }
    }

    public void OnBuffButton()
    {
        if (state != BattleState.ATTACK)
        {
            return;
        }
        StartCoroutine(PlayerBuff());
    }

    IEnumerator PlayerBuff()
    {
        player.CastBuff();
        hud.UpdatePlayerHP(player.currentHealth);

        hud.attackButtons.GetComponent<Animator>().Play("Slide Left");
        hud.phaseText.GetComponentInParent<Animator>().Play("Slide Up");

        //enemy turn
        yield return new WaitForSeconds(1f);
        state = BattleState.DEFENSE;
        hud.UpdatePhase(state);
        yield return new WaitForSeconds(2f);
        StartCoroutine(EnemyTurn());
    }

    public void OnDebuffButton()
    {
        if (state != BattleState.ATTACK)
        {
            return;
        }
        StartCoroutine(PlayerDebuff());
    }

    IEnumerator PlayerDebuff()
    {
        player.CastDebuff();
        hud.UpdatePlayerHP(player.currentHealth);

        hud.attackButtons.GetComponent<Animator>().Play("Slide Left");
        hud.phaseText.GetComponentInParent<Animator>().Play("Slide Up");

        //enemy turn
        yield return new WaitForSeconds(1f);
        state = BattleState.DEFENSE;
        hud.UpdatePhase(state);
        yield return new WaitForSeconds(2f);
        StartCoroutine(EnemyTurn());
    }


    void EndBattle()
    {
        if (state == BattleState.WON)
        {
            Debug.Log("You Won!");
        }
        else if (state == BattleState.LOST)
        {
            Debug.Log("You Lost!");
        }
    }
}
