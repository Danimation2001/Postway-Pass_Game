using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using TMPro;
using UnityEngine;

public class MainMenu : MonoBehaviour
{
    public Animator playPanel;
    public Animator instructionPanel;
    public Animator menuPanel;
    public TMP_Dropdown songSelector;
    public string selectedSong;
    public bool pPanelOut = false;
    public bool iPanelOut = false;
    public TMP_Text highScoreText;
    public TMP_Text hitPercentText;

    private void Start()
    {
        SelectSong();
    }

    public void SelectSong()
    {
        switch (songSelector.value)
        {
            case 0:
                LoadSong("Solo");
                break;

            case 1:
                LoadSong("Metronome");
                break;

            case 2:
                LoadSong("Reload");
                break;
        }
    }

    void LoadSong(string name)
    {
        selectedSong = name;
        RhythmManager.instance.selectedSongName = name;
        RhythmManager.instance.InitializeScores();
        RhythmManager.instance.bestScore = 0;
        RhythmManager.instance.bestHitPercent = 0f;

        if (!System.IO.File.Exists(Application.persistentDataPath + "/" + name + " savedata.json"))
        {
            RhythmManager.instance.SavePlayerData();
            highScoreText.text = "0";
            hitPercentText.text = "0.00%";
        }
        else
        {
            RhythmManager.instance.LoadPlayerData();
        }
    }

    public void AnimatePanel(int panelID)
    {

        if (panelID == 1 && !pPanelOut)
        {
            playPanel.SetBool("Panel Out", true);
            pPanelOut = true;
        }
        if (panelID == 1 && iPanelOut)
        {
            instructionPanel.SetBool("Panel Out", false);
            iPanelOut = false;
        }

        if (panelID == 2 && !iPanelOut)
        {
            instructionPanel.SetBool("Panel Out", true);
            iPanelOut = true;
        }
        if (panelID == 2 && pPanelOut)
        {
            playPanel.SetBool("Panel Out", false);
            pPanelOut = false;
        }

        if (pPanelOut || iPanelOut)
        {
            menuPanel.Play("Main Shift");
        }
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
