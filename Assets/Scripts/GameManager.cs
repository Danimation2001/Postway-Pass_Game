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

    public int sceneID;

    [Header ("Enemy Tracking")]
    public GameObject encounteredEnemyCombatPrefab;
    public List<int> defeatedEnemies = new List<int>();
    public int encounteredEnemy;

    [Header ("Respawning")]
    public bool needsReposition = false;
    public Vector3 lastPlayerPosition;
    public Quaternion lastPlayerRotation;
    
    [Header ("Collectables")]
    public int potionCount;
    public int mailCount;
    public int goldMailCount;
    public int maxMail;
    public int maxGoldMail;
    public bool maxCounted;
    public List<int> collectedPotions = new List<int>();
    public List<int> collectedMail = new List<int>();
    public List<int> collectedGoldMail = new List<int>();

    [Header ("Winter Level")]
    public bool hasFrozenKey;
    public bool unlockedCemeteryGate;

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
}