using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour
{
    Slider _slider;
    public Gradient gradient;
    public Image fill;

    void Start()
    {
        _slider = GetComponent<Slider>();
    }

    public void SetMaxHealth(int health)
    {
        _slider.maxValue = health;
        _slider.value = health;

        fill.color = gradient.Evaluate(1f);
    }

    public void SetHealth(int health)
    {
        _slider.value = health;

        fill.color = gradient.Evaluate(_slider.normalizedValue);
    }
}