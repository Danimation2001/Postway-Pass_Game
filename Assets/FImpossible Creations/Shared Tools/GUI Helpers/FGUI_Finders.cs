#if UNITY_EDITOR

using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace FIMSpace.FEditor
{
    public static class FGUI_Finders
    {
        public static Component FoundAnimator;
        private static bool checkForAnim = true;
        private static int clicks = 0;

        /// <summary>
        /// Resetting static finders for new searching
        /// </summary>
        public static void ResetFinders(bool resetClicks = true)
        {
            checkForAnim = true;
            FoundAnimator = null;
            if ( resetClicks ) clicks = 0;
        }


        /// <summary>
        /// Searching for animator in given root object and it's parents
        /// If you want to search new aniamtor you have to call ResetFinders()
        /// </summary>
        /// <returns> Returns true if animator is found, enabled and have controller </returns>
        public static bool CheckForAnimator(GameObject root, bool needAnimatorBox = true, bool drawInactiveWarning = true, int clicksTohide = 1)
        {
            bool working = false;

            if (checkForAnim)
            {
                FoundAnimator = SearchForParentWithAnimator(root);
            }

            // Drawing animator specific dialogs
            if (FoundAnimator)
            {
                Animation legacy = FoundAnimator as Animation;
                Animator mec = FoundAnimator as Animator;

                if (legacy) if (legacy.enabled) working = true;

                if (mec) // Mecanim found but no controller assigned
                {
                    if (mec.enabled) working = true;

                    if (mec.runtimeAnimatorController == null)
                    {
                        EditorGUILayout.HelpBox("  No 'Animator Controller' inside Animator ("+FoundAnimator.transform.name+")", MessageType.Warning);
                        drawInactiveWarning = false;
                        working = false;
                    }
                }

                // Drawing dialogs for warnings
                if (needAnimatorBox)
                {
                    if (drawInactiveWarning)
                    {
                        if (!working)
                        {
                            GUILayout.Space(-4);
                            FGUI_Inspector.DrawWarning(" ANIMATOR IS DISABLED! ");
                            GUILayout.Space(2);
                        }
                    }
                }
            }
            else
            {
                if (needAnimatorBox)
                {
                    if (clicks < clicksTohide)
                    {
                        GUILayout.Space(-4);
                        if (FGUI_Inspector.DrawWarning(" ANIMATOR NOT FOUND! ")) clicks++;
                        GUILayout.Space(2);
                    }
                }
            }

            checkForAnim = false;
            return working;
        }



        /// <summary>
        /// Searching in first children for animation/animator components
        /// If not found then searching in parents
        /// </summary>
        /// <returns> Returns transform with component or null if not found </returns>
        public static Component SearchForParentWithAnimator(GameObject root)
        {
            Animation animation = root.GetComponentInChildren<Animation>();
            if (animation) return animation;
            Animator animator = root.GetComponentInChildren<Animator>();
            if (animator) return animator;

            if (root.transform.parent != null)
            {
                Transform pr = root.transform.parent;

                while (pr != null)
                {
                    animation = pr.GetComponent<Animation>();
                    if (animation) return animation;
                    animator = pr.GetComponent<Animator>();
                    if (animator) return animator;

                    pr = pr.parent;
                }
            }

            return null;
        }


        /// <summary>
        /// Finding skinned mesh renderer with largest count of bones
        /// </summary>
        public static SkinnedMeshRenderer GetBoneSearchArray(Transform root)
        {
            List<SkinnedMeshRenderer> skins = new List<SkinnedMeshRenderer>();
            SkinnedMeshRenderer largestSkin = null;

            foreach (var t in root.GetComponentsInChildren<Transform>())
            {
                SkinnedMeshRenderer s = t.GetComponent<SkinnedMeshRenderer>(); if (s) skins.Add(s);
            }

            // Searching in parent
            if (skins.Count == 0)
            {
                Transform lastParent = root;

                while (lastParent != null)
                {
                    if (lastParent.parent == null) break;
                    lastParent = lastParent.parent;
                }

                foreach (var t in lastParent.GetComponentsInChildren<Transform>())
                {
                    SkinnedMeshRenderer s = t.GetComponent<SkinnedMeshRenderer>(); if (!skins.Contains(s)) if (s) skins.Add(s);
                }
            }

            if (skins.Count > 1)
            {
                largestSkin = skins[0];
                for (int i = 1; i < skins.Count; i++)
                    if (skins[i].bones.Length > largestSkin.bones.Length)
                        largestSkin = skins[i];
            }
            else
                if (skins.Count > 0) largestSkin = skins[0];

            if (largestSkin == null) return null;
            return largestSkin;
        }

        /// <summary>
        /// Checking if transform is child of choosed root bone parent transform
        /// </summary>
        public static bool IsChildOf(Transform child, Transform rootParent)
        {
            Transform tParent = child;
            while (tParent != null && tParent != rootParent)
            {
                tParent = tParent.parent;
            }

            if (tParent == null) return false; else return true;
        }


        /// <summary>
        /// Checking if transform is child of choosed root bone parent transform
        /// </summary>
        public static Transform GetLastChild(Transform rootParent)
        {
            Transform tChild = rootParent;
            while (tChild.childCount > 0) tChild = tChild.GetChild(0);
            return tChild;
        }

        /// <summary>
        /// Returns true if right keyword exists, false if left, null if unknown
        /// </summary>
        public static bool? IsRightOrLeft(string name, bool includeNotSure = false)
        {
            string nameLower = name.ToLower();


            if (nameLower.Contains("right")) return true;
            if (nameLower.Contains("left")) return false;


            if (nameLower.StartsWith("r_")) return true;
            if (nameLower.StartsWith("l_")) return false;

            if (nameLower.EndsWith("_r")) return true;
            if (nameLower.EndsWith("_l")) return false;

            if (nameLower.StartsWith("r.")) return true;
            if (nameLower.StartsWith("l.")) return false;

            if (nameLower.EndsWith(".r")) return true;
            if (nameLower.EndsWith(".l")) return false;

            if ( includeNotSure)
            {
                if (nameLower.Contains("r_")) return true;
                if (nameLower.Contains("l_")) return false;

                if (nameLower.Contains("_r")) return true;
                if (nameLower.Contains("_l")) return false;

                if (nameLower.Contains("r.")) return true;
                if (nameLower.Contains("l.")) return false;

                if (nameLower.Contains(".r")) return true;
                if (nameLower.Contains(".l")) return false;
            }

            return null;
        }

        /// <summary>
        /// Returns true if child is on the right of root's relation, false if on the left, null if on the middle
        /// </summary>
        public static bool? IsRightOrLeft(Transform child, Transform itsRoot)
        {
            Vector3 transformed = itsRoot.InverseTransformPoint(child.position);
            if (transformed.x < 0f) return false; else
            if (transformed.x > 0f) return true;
            return null;
        }


        public static bool HaveKey(string text, string[] keys)
        {
            for (int i = 0; i < keys.Length; i++)
                if (text.Contains(keys[i])) return true;
            
            return false;
        }

    }
}

#endif
