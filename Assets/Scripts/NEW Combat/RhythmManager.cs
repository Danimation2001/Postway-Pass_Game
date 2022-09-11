using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using TMPro;

public class RhythmManager : MonoBehaviour
{
    
    public bool inGame = false;
    public SaveData data;
    public MainMenu mainMenu;
    public GameObject mainMenuUI;
    public GameObject gameUI;
    public TextMeshProUGUI songNameText; //text that displays the name of the song
    public GameObject readyPanel; //UI element that is displayed before the song plays
    public GameObject endPanel; //menu at the end of the song
    public GameObject gameOverPanel;
    public TextMeshProUGUI scoreText; //text that displays the score
    public TextMeshProUGUI prevScoreText; //text that displays the previous best score
    public TextMeshProUGUI missedText; //displays the number of missed notes
    public TextMeshProUGUI hitText; //displays the number of hit notes
    public TextMeshProUGUI multiplierText; //displays the multiplier
    public Slider healthSlider;
    public string selectedSongName;
    public int score;
    public int bestScore; //previous best score
    public int missedNotes; //tracks the number of missed notes in the song
    public int hitNotes; //tracks the number of hit notes in the song
    public float hitPercent;
    public float bestHitPercent;
    public int multiplier; //value to multiply the score with
    public int multiplierTracker; //tracks how many notes have been hit in a row
    public int[] multiThresholds; //how many notes need to be hit in a row before the multiplier is increased
    public bool gameOver = false;

    private static RhythmManager _instance;

    public static RhythmManager instance
    {
        get
        {
            return _instance;
        }
    }

    void Awake()
    {
        _instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        InitializeScores();
    }

    // Update is called once per frame
    void Update()
    {
        //update text with values
        scoreText.text = score.ToString();
        hitText.text = "HITS " + hitNotes;
        missedText.text = "MISSES " + missedNotes;
        multiplierText.text = "X" + multiplier;

        //update previous best if beaten
        if (score > bestScore)
        {
            bestScore = score;
            prevScoreText.text = "PREVIOUS BEST " + bestScore;
        }
    }

    public void AddScore(int amount)
    {
        score += amount * multiplier;
    }

    float GetHitPercent()
    {
        if (hitNotes + missedNotes > 0 && hitNotes > 0)
        {
            float total = hitNotes + missedNotes;
            return (hitNotes / total * 100);
        }
        else
        {
            return 0f;
        }
    }


    public void IncreaseMultiplier()
    {
        if (multiThresholds[multiplier - 1] <= multiplierTracker)
        {
            multiplierTracker = 0;
            multiplier++;
        }
    }

    public void ResetMultiplier()
    {
        multiplier = 1;
        multiplierTracker = 0;
    }

    public void SetSongName(string name)
    {
        songNameText.text = name;
    }

    public void GameOver()
    {
        gameOverPanel.SetActive(true);
        Conductor.instance.musicSource.Stop();
        gameOver = true;
    }

    public void RetrySong()
    {
        if (gameOver)
        {
            gameOverPanel.SetActive(false);
            gameOver = false;
        }

        endPanel.SetActive(false);
        readyPanel.SetActive(true);
        string currentScene = SceneManager.GetActiveScene().name;
        SceneManager.LoadScene(currentScene);
        InitializeScores();
    }

    public void InitializeScores()
    {
        score = 0;
        missedNotes = 0;
        hitPercent = 0;
        hitNotes = 0;
        multiplier = 1;
        multiplierTracker = 0;
        scoreText.text = score.ToString();
        prevScoreText.text = "PREVIOUS BEST " + bestScore;
    }

    public void ResetMenu()
    {
        mainMenu.pPanelOut = false;
        mainMenu.iPanelOut = false;
        mainMenu.playPanel.SetBool("Panel Out", false);
        mainMenu.instructionPanel.SetBool("Panel Out", false);
        mainMenu.playPanel.Play("Idle Panel");
        mainMenu.instructionPanel.Play("Idle Panel");
        mainMenu.menuPanel.Play("Idle Menu");
    }

    public void FinishedSong()
    {
        Conductor.instance.musicSource.Stop();
        endPanel.SetActive(true);

        hitPercent = GetHitPercent();
        if (hitPercent > bestHitPercent)
        {
            bestHitPercent = hitPercent;
        }
        else if (hitPercent < bestHitPercent)
        {
            hitPercent = bestHitPercent;
        }

        SavePlayerData();
    }

    public void SavePlayerData()
    {
        string s = data.ToJson();
        Debug.Log(s);
        System.IO.File.WriteAllText(Application.persistentDataPath + "/" + selectedSongName + " savedata.json", s);
    }

    public void LoadPlayerData()
    {
        string s = System.IO.File.ReadAllText(Application.persistentDataPath + "/" + selectedSongName + " savedata.json");
        SaveData c = SaveData.FromJson(s);

        bestScore = c.highScore;
        bestHitPercent = c.hitPercent;
        mainMenu.highScoreText.text = bestScore.ToString();
        mainMenu.hitPercentText.text = c.hitPercent.ToString("F2") + "%";
        prevScoreText.text = bestScore.ToString();
    }
}
