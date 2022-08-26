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
	/// <see cref="MaterialPayload"/>-specific functionality.
	/// </summary>
	public static class MaterialPayloadEventExtensions
	{
		#region KoreographyEvent Extension Methods
		
		/// <summary>
		/// Determines if the payload is of type <see cref="MaterialPayload"/>.
		/// </summary>
		/// <returns><c>true</c> if the payload is of type <see cref="MaterialPayload"/>;
		/// otherwise, <c>false</c>.</returns>
		public static bool HasMaterialPayload(this KoreographyEvent koreoEvent)
		{
			return (koreoEvent.Payload as MaterialPayload) != null;
		}
		
		/// <summary>
		/// Returns the asset reference associated with the MaterialPayload.  If the
		/// Payload is not actually of type <see cref="MaterialPayload"/>, this will return
		/// null.
		/// </summary>
		/// <returns>The <c>asset reference</c>.</returns>
		public static Material GetMaterialValue(this KoreographyEvent koreoEvent)
		{
			Material retVal = null;
			
			MaterialPayload pl = koreoEvent.Payload as MaterialPayload;
			if (pl != null)
			{
				retVal = pl.MaterialVal;
			}
			
			return retVal;
		}
		
		#endregion
	}
	
	/// <summary>
	/// The MaterialPayload class allows Koreorgraphy Events to contain a reference to
	/// an asset as a payload.
	/// </summary>
	[System.Serializable]
	public class MaterialPayload : IPayload
	{
		#region Fields
		
		[SerializeField]
		[Tooltip("The Material reference stored in the payload.")]
		Material mMaterialVal;
		
		#endregion
		#region Properties
		
		/// <summary>
		/// Gets or sets the asset reference value.
		/// </summary>
		/// <value>The asset reference value.</value>
		public Material MaterialVal
		{
			get
			{
				return mMaterialVal;
			}
			set
			{
				mMaterialVal = value;
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
			return "Material";
		}
		
		#endregion
		#region IPayload Interface

#if UNITY_EDITOR
		
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
			
			EditorGUI.BeginChangeCheck();

			float pickerWidth = 20f;
			Material newVal = null;

			// Handle short fields.
			if (displayRect.width >= pickerWidth + 2f)
			{
				// HACK to make the background of the picker icon readable.
				Rect pickRect = new Rect(displayRect);
				pickRect.xMin = pickRect.xMax - pickerWidth;
				GUI.Box(pickRect, string.Empty, EditorStyles.textField);
				
				// Draw the Material field.
				newVal = EditorGUI.ObjectField(displayRect, MaterialVal, typeof(Material), false) as Material;
			}
			else
			{
				// Simply show a text field.
				string name = (MaterialVal != null) ? MaterialVal.name : "None (Material)";
				string tooltip = isSelected ? "Edit in the \"Selected Event Settings\" section below." : "Select this event and edit in the \"Selected Event Settings\" section below.";
				GUI.Box(displayRect, new GUIContent(name, tooltip), EditorStyles.textField);
			}

			if (EditorGUI.EndChangeCheck())
			{
				Undo.RecordObject(track, "Modify Material Payload");
				MaterialVal = newVal;
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
			MaterialPayload newPL = new MaterialPayload();
			newPL.MaterialVal = MaterialVal;
			
			return newPL;
		}
		
		#endregion
	}
}
