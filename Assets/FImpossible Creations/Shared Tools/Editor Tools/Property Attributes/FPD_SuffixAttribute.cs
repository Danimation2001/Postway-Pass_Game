using UnityEngine;

public class FPD_SuffixAttribute : PropertyAttribute
{
    public readonly float Min;
    public readonly float Max;
    public readonly SuffixMode Mode;
    public readonly string Suffix;
    public readonly bool editableValue;

    public enum SuffixMode
    {
        From0to100,
        PercentageUnclamped,
        FromMinToMax,
        FromMinToMaxRounded
    }

    public FPD_SuffixAttribute(float min, float max, SuffixMode mode = SuffixMode.From0to100, string suffix = "%", bool editable = true)
    {
        Min = min;
        Max = max;
        Mode = mode;
        Suffix = suffix;
        editableValue = editable;
    }
}

