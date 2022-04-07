using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BattleHUD : MonoBehaviour
{
    public TMP_Text enemyNameText;
    public TMP_Text phaseText;
    public HealthBar enemyHPBar;
    public HealthBar playerHPBar;
    public GameObject attackButtons;

    public void SetEnemyHUD(Unit _unit)
    {
        enemyNameText.text = _unit.unitName;
        enemyHPBar.SetMaxHealth(_unit.maxHealth);
    }

    public void SetPlayerHUD(BattlePlayer _player)
    {
        playerHPBar.SetMaxHealth(_player.maxHealth);
    }

    public void UpdateEnemyHP(int _health)
    {
        enemyHPBar.SetHealth(_health);
    }

    public void UpdatePhase(BattleState _state)
    {
        if (_state == BattleState.ATTACK)
        {
            phaseText.text = "ATTACK PHASE";
            attackButtons.SetActive(true);
        }
        else if (_state == BattleState.DEFENSE)
        {
            phaseText.text = "DEFENSE PHASE";
            attackButtons.SetActive(false);
        }
        else
        {
            phaseText.text = "WAITING...";
            attackButtons.SetActive(false);
        }
    }
}
