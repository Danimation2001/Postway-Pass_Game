//----------------------------------------------
//            	   Koreographer                 
//    Copyright © 2014-2020 Sonic Bloom, LLC    
//----------------------------------------------

using UnityEngine;
using System.Collections.Generic;

namespace SonicBloom.Koreo.Demos
{
#if !(UNITY_4_5 || UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
	// This attribute adds the class to the Assets/Create menu so that it may be
	//	instantiated. [Requires Unity 5.1.0 and up.]
	[CreateAssetMenuAttribute(fileName = "New CustomKoreographyTrack", menuName = "Custom Koreography Track")]
#endif
	public class CustomKoreographyTrack : KoreographyTrack
	{
		#region Serialization Handling

		/**
		 * For each custom Payload Type you wish to add, you must add two lists of the following format:
		 * 		List<[PayloadType]> _[PayloadType]s
		 * 		List<int> _[PayloadType]Idxs
		 * where [PayloadType] is the literal name of the custom payload's class name. This matches how
		 * Payloads in the core KoreographyTrack are defined. An example is:
		 * 		List<IntPayload> _IntPayloads;
		 * 		List<int> _IntPayloadIdxs;
		 * 
		 * This is done to support serialization as Unity does not yet provide support for serialization
		 * with polymorphism (properly handling subclasses in a container [e.g. List<>] that is typed as
		 * a super class). Internally, each Koreography Track maintains a list typed with an Interface
		 * that payload classes implement. Without these specially typed and named lists, serialization
		 * will fail.
		 * 
		 * Also note the use of the [HideInInspector] and [SerializeField] attributes. The
		 * [HideInInspector] attribute stops the field from appearing in the Inspector (unless Debug
		 * mode is enabled). The [SerializeField] option is REQUIRED unless you set the field to public,
		 * in which case this attribute is unnecessary.
		 */

		[HideInInspector][SerializeField]
		protected List<MaterialPayload>	_MaterialPayloads;		// List that stores MaterialPayload types.
		[HideInInspector][SerializeField]
		protected List<int>				_MaterialPayloadIdxs;	// List that stores indices of MaterialPayload types in the Koreography Track.

		#endregion
	}
}
