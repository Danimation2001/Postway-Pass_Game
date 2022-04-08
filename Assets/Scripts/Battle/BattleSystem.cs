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
    public BattlePlayer player;
    public BattleHUD hud;
    public float entryTime;

    // Start is called before the first frame update
    void Start()
    {
        state = BattleState.START;
        hud.UpdatePhase(state);
        StartCoroutine(SetupBattle());
    }

    IEnumerator SetupBattle()
    {
        GameObject enemyGO = Instantiate(enemyPrefab, spawnLocation);
        _enemyUnit = enemyGO.GetComponent<Unit>();
        hud.SetEnemyHUD(_enemyUnit);
        hud.SetPlayerHUD(player);

        yield return new WaitForSeconds(entryTime);

        state = BattleState.ATTACK;
        hud.UpdatePhase(state);
        PlayerTurn();
    }

    IEnumerator PlayerAttack()
    {
        //damage enemy
        bool _isDead = _enemyUnit.TakeDamage(player.damage);

        hud.UpdateEnemyHP(_enemyUnit.currentHealth);

        yield return new WaitForSeconds(2f);

        //check if enemy died
        if (_isDead)
        {
            //end battle
            state = BattleState.WON;
            EndBattle();
        }
        else
        {
            //enemy turn
            state = BattleState.DEFENSE;
            //StartCoroutine(EnemyTurn());
        }
    }

    void PlayerTurn()
    {

    }

    // IEnumerator EnemyTurn()
    // {

    // }

    public void OnAttackButton()
    {
        if (state != BattleState.ATTACK)
        {
            return;
        }
        StartCoroutine(PlayerAttack());
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
