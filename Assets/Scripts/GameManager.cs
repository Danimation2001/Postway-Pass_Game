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
    public bool needsReposition = false;
    public Vector3 lastPlayerPosition;
    public Quaternion lastPlayerRotation;

    [Header("Collectables")]
    public int potionCount;
    public int mailCount;
    public int goldMailCount;
    public int maxMail;
    public int maxGoldMail;
    [HideInInspector] public bool maxCounted;
    [HideInInspector] public List<int> collectedPotions = new List<int>();
    [HideInInspector] public List<int> collectedMail = new List<int>();
    [HideInInspector] public List<int> collectedGoldMail = new List<int>();

    //[Header("Summer Level")]

    //[Header("Autumn Level")]

    [Header("Winter Level")]
    public bool hasFrozenKey;
    public bool unlockedCemeteryGate;
    public bool defeatedWinterBoss;

    //[Header("Spring Level")]

    [Header("Combat")]
    public bool gameOver;
    public void CollectMaxMails()
    {
        List<GameObject> mail = new List<GameObject>();
        mail.AddRange(GameObject.FindGameObjectsWithTag("Mail"));
        mail.AddRange(GameObject.FindGameObjectsWithTag("Hidden Mail"));
        maxMail = mail.Count;

        GameObject[] goldMail = GameObject.FindGameObjectsWithTag("GoldMail");
        maxGoldMail = goldMail.Length;
        maxCounted = true;
    }

    public void RepositionPlayer(Transform _player)
    {
        _player.GetComponent<RBController>().enabled = false;
        _player.GetComponent<Rigidbody>().isKinematic = true;
        _player.GetComponent<UnityEngine.InputSystem.PlayerInput>().enabled = false;
        _player.position = lastPlayerPosition;
        _player.rotation = lastPlayerRotation;
        _player.GetComponent<UnityEngine.InputSystem.PlayerInput>().enabled = true;
        _player.GetComponent<Rigidbody>().isKinematic = false;
        _player.GetComponent<RBController>().enabled = true;
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
        hasFrozenKey = false;
        unlockedCemeteryGate = false;
        defeatedWinterBoss = false;
        gameOver = false;
    }

    public void FinishedSong(string name)
    {
        Conductor.instance.musicSource.Stop();
        switch(name)
        {
            case "Winter":
                defeatedWinterBoss = true;
                SceneLoader.Instance.LoadWinterScene();
                break;
        }
    }

    public GameObject gameOverUI;

    public void GameOver()
    {
        Cursor.lockState = CursorLockMode.None;
        gameOver = true;
        Conductor.instance.musicSource.Stop();
        //gameOverUI = GameObject.Find("Game Over UI");
        //gameOverUI.GetComponent<Animator>().Play("Fade In");
        gameOverUI.SetActive(true);
    }
}