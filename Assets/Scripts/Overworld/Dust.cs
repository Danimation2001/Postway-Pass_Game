using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dust : MonoBehaviour
{
    public ParticleSystem dustEmitterR, dustEmitterL;

    public void CreateDustRight()
    {
        dustEmitterR.Play();
    }

    public void CreateDustLeft()
    {
        dustEmitterL.Play();
    }

    public void CreateDustBoth()
    {
        CreateDustLeft();
        CreateDustRight();
    }
}
