using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class OverworldUI : MonoBehaviour
{
    public TMP_Text potionText;
    public TMP_Text mailText;
    public TMP_Text goldMailText;

    void Update()
    {
        mailText.text = GameManager.Instance.mailCount.ToString();
        potionText.text = GameManager.Instance.potionCount.ToString();
        //goldMailText.text = GameManager.Instance.goldMailCount.ToString();
    }
}