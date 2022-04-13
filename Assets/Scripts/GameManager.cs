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
    public List<int> defeatedEnemies = new List<int>();
    public int encounteredEnemy;
    public bool inCombat = false;
    public bool needsReposition = false;
    public int sceneID;
    Transform _playerTransform;

    void Update()
    {
        if (!inCombat && _playerTransform == null && GameObject.FindGameObjectWithTag("Player") != null)
        {
            _playerTransform = GameObject.FindGameObjectWithTag("Player").transform;

            if (needsReposition)
            {
                _playerTransform.position = lastPlayerPosition;
                needsReposition = false;
            }
        }
    }
}