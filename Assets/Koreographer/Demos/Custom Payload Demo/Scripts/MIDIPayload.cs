//----------------------------------------------
//            	   Koreographer                 
//    Copyright © 2014-2020 Sonic Bloom, LLC    
//----------------------------------------------

using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace SonicBloom.Koreo.Demos
{
	/// <summary>
	/// Extension Methods for the <see cref="KoreographyEvent"/> class that add
	/// <see cref="MIDIPayload"/>-specific functionality.
	/// </summary>
	public static class MIDIPayloadEventExtensions
	{
		#region KoreographyEvent Extension Methods

		/// <summary>
		/// Determines if the payload is of type <see cref="MIDIPayload"/>.
		/// </summary>
		/// <returns><c>true</c> if the payload is of type <see cref="MIDIPayload"/>;
		/// otherwise, <c>false</c>.</returns>
		public static bool HasMIDIPayload(this KoreographyEvent koreoEvent)
		{
			return (koreoEvent.Payload as MIDIPayload) != null;
		}

		/// <summary>
		/// Retrieves the MIDI note and velocity values from the Payload. The note
		/// and velocity values will not be changed if the Payload is not actually
		/// <see cref="MIDIPayload"/> type.
		/// </summary>
		/// <param name="koreoEvent">The <c>this</c> <see cref="KoreographyEvent"/>.</param>
		/// <param name="note">The MIDI Note value. Range [0, 127].</param>
		/// <param name="velocity">The MIDI Velocity value. Range [0, 127].</param>
		public static void GetMIDIValues(this KoreographyEvent koreoEvent, ref int note, ref int velocity)
		{
			MIDIPayload pl = koreoEvent.Payload as MIDIPayload;
			if (pl != null)
			{
				note = pl.NoteVal;
				velocity = pl.VelocityVal;
			}
		}

		#endregion
	}


	[System.Serializable]
	public class MIDIPayload : IPayload
	{
		#region Feilds

		[SerializeField]
		[Tooltip("The raw MIDI note value. Range: [0, 127].")]
		int mNote;
		[SerializeField]
		[Tooltip("The raw MIDI velocity value. Range: [0, 127].")]
		public int mVelocity;

		#endregion
		#region Properties

		/// <summary>
		/// Gets or sets the MIDI Note value [0, 127].
		/// </summary>
		/// <value>The MIDI Note value.</value>
		public int NoteVal
		{
			get
			{
				return mNote;
			}
			set
			{
				mNote = Mathf.Clamp(value, 0, 127);
			}
		}

		/// <summary>
		/// Gets or sets the MIDI Velocity value [0, 127].
		/// </summary>
		/// <value>The MIDI Velocity value.</value>
		public int VelocityVal
		{
			get
			{
				return mVelocity;
			}
			set
			{
				mVelocity = Mathf.Clamp(value, 0, 127);
			}
		}

		#endregion
		#region Standard Methods

		/// <summary>
		/// This is used by the Koreography Editor to create the Payload type entry
		/// in the UI dropdown.
		/// </summary>
		/// <returns>The friendly name of the class.</returns>
		public static string GetFriendlyName()
		{
			return "MIDI";
		}

		#endregion
		#region IPayload Interface

#if UNITY_EDITOR

		static GUIContent noteTooltipContent = new GUIContent("", "Note");
		static GUIContent velTooltipContent = new GUIContent("", "Velocity");

		/// <summary>
		/// Used for drawing the GUI in the Editor Window (possibly scene overlay?).  Undo is
		/// supported.
		/// </summary>
		/// <returns><c>true</c>, if the Payload was edited in the GUI, <c>false</c>
		/// otherwise.</returns>
		/// <param name="displayRect">The <c>Rect</c> within which to perform GUI drawing.</param>
		/// <param name="track">The Koreography Track within which the Payload can be found.</param>
		/// <param name="isSelected">Whether or not the Payload (or the Koreography Event that
		/// contains the Payload) is selected in the GUI.</param>
		public bool DoGUI(Rect displayRect, KoreographyTrackBase track, bool isSelected)
		{
			bool bDidEdit = false;
			Color originalBG = GUI.backgroundColor;
			GUI.backgroundColor = isSelected ? Color.green : originalBG;

			int note = 0;
			int velocity = 0;

			EditorGUI.BeginChangeCheck();
			{
				float width = displayRect.width / 2;

				Rect rect = new Rect(displayRect);
				rect.xMax = rect.xMin + width;
				note = EditorGUI.IntField(rect, NoteVal); 			// Value
				GUI.Box(rect, noteTooltipContent, GUIStyle.none);	// Tooltip

				rect.xMin = rect.xMax;
				rect.xMax = rect.xMin + width;
				velocity = EditorGUI.IntField(rect, VelocityVal);	// Value
				GUI.Box(rect, velTooltipContent, GUIStyle.none);	// Tooltip
			}
			if (EditorGUI.EndChangeCheck())
			{
				Undo.RecordObject(track, "MIDI Payload Changed");
				NoteVal = note;
				VelocityVal = velocity;
				bDidEdit = true;
			}

			GUI.backgroundColor = originalBG;
			return bDidEdit;
		}

		/// <summary>
		/// Used to determine the Payload's desired width for rendering in certain contexts
		/// (e.g. in Peek UI). Return <c>0</c> to indicate a default width.
		/// </summary>
		/// <returns>The desired width for UI rendering or <c>0</c> to use the default.</returns>
		public float GetDisplayWidth()
		{
			return 0f;	// Use default.
		}

#endif

		/// <summary>
		/// Returns a copy of the current object, including the pertinent parts of
		/// the payload.
		/// </summary>
		/// <returns>A copy of the Payload object.</returns>
		public IPayload GetCopy()
		{
			MIDIPayload newPL = new MIDIPayload();

			newPL.NoteVal = NoteVal;
			newPL.VelocityVal = VelocityVal;

			return newPL;
		}

		#endregion
	}
}
