using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour
{
    Slider _slider;
    public Sprite[] emotes;
    public Image emoteImage;
    Animator emoteAnim;
    Animator healthAnim;

    void Start()
    {
        _slider = GetComponent<Slider>();
        emoteAnim = emoteImage.gameObject.GetComponent<Animator>();
        healthAnim = GetComponent<Animator>();
    }

    public void SetMaxHealth(int health)
    {
        _slider.maxValue = health;
        _slider.value = health;
    }

    public void SetHealth(int health)
    {
        _slider.value = health;
        if (_slider.value < _slider.maxValue)
        {
            healthAnim.Play("Shake");
        }
        EvaluateEmote();
    }

    void EvaluateEmote()
    {
        if (_slider.value >= 75)
        {
            if (emoteImage.sprite != emotes[0])
            {
                emoteAnim.Play("Bounce");
            }
            emoteImage.sprite = emotes[0];
        }
        else if (_slider.value >= 50)
        {
            if (emoteImage.sprite != emotes[1])
            {
                emoteAnim.Play("Bounce");
            }
            emoteImage.sprite = emotes[1];
        }
        else if (_slider.value >= 25)
        {
            if (emoteImage.sprite != emotes[2])
            {
                emoteAnim.Play("Bounce");
            }
            emoteImage.sprite = emotes[2];
        }
        else
        {
            if (emoteImage.sprite != emotes[3])
            {
                emoteAnim.Play("Bounce");
            }
            emoteImage.sprite = emotes[3];
        }
    }
}