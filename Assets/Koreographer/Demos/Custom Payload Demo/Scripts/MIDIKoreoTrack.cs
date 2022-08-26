//----------------------------------------------
//            	   Koreographer                 
//    Copyright © 2014-2020 Sonic Bloom, LLC    
//----------------------------------------------

using UnityEngine;
using System.Collections.Generic;

namespace SonicBloom.Koreo.Demos
{
	/**
	 * This is core of the MIDIKoreoTrack class. It defines everything necessary
	 * for use at runtime. 
	 */ 
#if !(UNITY_4_5 || UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
	// This attribute adds the class to the Assets/Create menu so that it may be
	//	instantiated. [Requires Unity 5.1.0 and up.]
	[CreateAssetMenuAttribute(fileName = "New CustomKoreographyTrack", menuName = "Custom Koreography Track")]
#endif
	public partial class MIDIKoreoTrack : KoreographyTrackBase
	{
		/**
		 * Please see the CustomKoreographyTrack.cs file (as well as the included documentation)
		 * for an explanation of the fields defined here and why they are necessary.
		 */

		[HideInInspector][SerializeField]
		protected List<MIDIPayload> _MIDIPayloads;	// List that stores MIDIPayload types.
		[HideInInspector][SerializeField]
		protected List<int> _MIDIPayloadIdxs;		// List that stores indices of MIDIPayload types in the Koreography Track.
	}

#if UNITY_EDITOR

	/**
	 * This is an editor-only portion of the MIDIKoreoTrack class. It implements
	 * the Interface necessary to hook into the MIDI Converter's custom conversion
	 * functionality.
	 */
	public partial class MIDIKoreoTrack : IMIDIConvertible
	{
		/// <summary>
		/// Converts the passed in MIDI events into KoreographyEvents with payload of type
		/// <see cref="MIDIPayload"/>. The Payload stores both the Velocity and the Note
		/// values. Any previously existing events will be overwritten.
		/// </summary>
		/// <param name="events">The list of raw <see cref="KoreoMIDIEvent"/>s to convert.</param>
		public void ConvertMIDIEvents(List<KoreoMIDIEvent> events)
		{
			// A change is very likely to occur as this function overwrites existing
			// events.
			UnityEditor.Undo.RecordObject(this, "Convert MIDI Events");

			this.RemoveAllEvents();

			foreach (KoreoMIDIEvent evt in events)
			{
				KoreographyEvent newEvt = new KoreographyEvent();
				newEvt.StartSample = evt.startSample;
				newEvt.EndSample = evt.endSample;

				MIDIPayload pl = new MIDIPayload();
				pl.NoteVal = evt.note;
				pl.VelocityVal= evt.velocity;
				newEvt.Payload = pl;

				this.AddEvent(newEvt);
			}
		}
	}

#endif

}
