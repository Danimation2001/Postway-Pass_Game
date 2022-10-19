using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    private static GameManager _instance;

    public static GameManager Instance
    {
        get
        {
            if (_instance is null)
            {
                Debug.LogError("Game Manager is NULL");
            }

            return _instance;
        }
    }

    void Awake()
    {
        if (_instance != null && _instance != this)
        {
            Destroy(gameObject);
        }
        else
        {
            _instance = this;
            DontDestroyOnLoad(this.gameObject);
        }
    }

    [HideInInspector] public int overworldSceneID;

    [Header("Enemy Tracking")]
    [HideInInspector] public GameObject encounteredEnemyCombatPrefab;
    [HideInInspector] public List<int> defeatedEnemies = new List<int>();
    [HideInInspector] public int encounteredEnemy;

    [Header("Respawning")]
    [HideInInspector] public bool needsReposition = false;
    [HideInInspector] public Vector3 lastPlayerPosition;
    [HideInInspector] public Quaternion lastPlayerRotation;

    [Header("Collectables")]
    [HideInInspector] public int potionCount;
    [HideInInspector] public int mailCount;
    [HideInInspector] public int goldMailCount;
    [HideInInspector] public int maxMail;
    [HideInInspector] public int maxGoldMail;
    [HideInInspector] public bool maxCounted;
    [HideInInspector] public List<int> collectedPotions = new List<int>();
    [HideInInspector] public List<int> collectedMail = new List<int>();
    [HideInInspector] public List<int> collectedGoldMail = new List<int>();

    //[Header("Summer Level")]

    //[Header("Autumn Level")]

    [Header("Winter Level")]
    [HideInInspector] public bool hasFrozenKey;
    [HideInInspector] public bool unlockedCemeteryGate;

    //[Header("Spring Level")]

    [Header("Combat")]
    [HideInInspector] public bool gameOver;

    public void CollectMaxMails()
    {
        GameObject[] mail = GameObject.FindGameObjectsWithTag("Mail");
        maxMail = mail.Length;

        GameObject[] goldMail = GameObject.FindGameObjectsWithTag("GoldMail");
        maxGoldMail = goldMail.Length;
        maxCounted = true;
    }

    public void RepositionPlayer(Transform _player)
    {
        _player.localPosition = lastPlayerPosition;
        _player.localRotation = lastPlayerRotation;
        needsReposition = false;
    }

    public void ResetAll()
    {
        encounteredEnemyCombatPrefab = null;
        lastPlayerPosition = Vector3.zero;
        lastPlayerRotation = Quaternion.Euler(Vector3.zero);
        defeatedEnemies.Clear();
        collectedPotions.Clear();
        collectedMail.Clear();
        collectedGoldMail.Clear();
        encounteredEnemy = 0;
        needsReposition = false;
        potionCount = 0;
        mailCount = 0;
        goldMailCount = 0;
        maxCounted = false;
        maxMail = 0;
        maxGoldMail = 0;
    }

    public void FinishedSong()
    {
        Conductor.instance.musicSource.Stop();
    }

    GameObject gameOverUI;

    public void GameOver()
    {
        gameOver = true;
        Conductor.instance.musicSource.Stop();
        gameOverUI = GameObject.Find("Game Over UI");
        gameOverUI.GetComponent<Animator>().Play("Fade In");
    }
}