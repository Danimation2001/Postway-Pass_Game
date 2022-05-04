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

    public GameObject encounteredEnemyCombatPrefab;
    public Vector3 lastPlayerPosition;
    public Quaternion lastPlayerRotation;
    public List<int> defeatedEnemies = new List<int>();
    public List<int> collectedPotions = new List<int>();
    public List<int> collectedMail = new List<int>();
    public int encounteredEnemy;
    public bool needsReposition = false;
    public int sceneID;
    public int potionCount;
    public int mailCount;

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
        encounteredEnemy = 0;
        needsReposition = false;
        potionCount = 0;
        mailCount = 0;
    }
}