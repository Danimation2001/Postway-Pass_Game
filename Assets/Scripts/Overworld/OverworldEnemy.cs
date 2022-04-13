using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OverworldEnemy : MonoBehaviour
{
    public int enemyID;
    public GameObject combatPrefab;

    // Start is called before the first frame update
    void Start()
    {
        foreach (int id in GameManager.Instance.defeatedEnemies) // check if this enemy is marked as being defeated
        {
            if (id == enemyID)
            {
                gameObject.SetActive(false);
            }
        }
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            GameManager.Instance.inCombat = true;
            GameManager.Instance.needsReposition = true;
            GameManager.Instance.encounteredEnemy = enemyID;
            GameManager.Instance.encounteredEnemyCombatPrefab = combatPrefab;
            GameManager.Instance.lastPlayerPosition = GameObject.FindGameObjectWithTag("Player").transform.position;
            SceneLoader.Instance.LoadCombatScene();
        }
    }
}