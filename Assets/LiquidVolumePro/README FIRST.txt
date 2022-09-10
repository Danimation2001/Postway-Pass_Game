***********************************************
*              LIQUID VOLUME PRO              *
*           By Ramiro Oliva (Kronnect)        *   
*                 README FILE                 *
***********************************************


How to use this asset
---------------------

Thanks for purchasing LIQUID VOLUME PRO!

Important: please read the brief quick start guide located in LiquidVolumePro/Documentation.


Support
-------

* Website-Forum Support: http://kronnect.com/support
* Twitter: @Kronnect
* Email (non support): contact@kronnect.com


Other Cool Assets!
------------------

Check our other assets on the Asset Store publisher page:
https://www.assetstore.unity3d.com/en/#!/search/page=1/sortby=popularity/query=publisher:15018



Current version
- [Fix] Fixed issue rendering irregular topology in Single Pass Instanced VR mode when interleaved rendering option is disabled

Version 4.5
- Minimum Unity version required is now 2020.3.16
- Some shader optimizations related to point light support
- [Fix] Fixed issue when ignoring gravity and using multiple layers

Version 4.4
- API: added GetMeshVolumeWS, GetMeshVolumeWSUnderLevel, GetMeshVolumeWSFast, GetMeshVolumeWSUnderLevelFast methods. They return approximations of the mesh volume
- API: added optional "rotationCompensation" parameter to GetSpillPoint method
- [Fix] Fixed inspector overlap issue in Unity 2021.3.3 due to a reorderable list bug

Version 4.3.2
- API: added onPropertiesChanged event
- Added "Interleaved Rendering" to depth prepass render feature. This option improves results when overlapping irregular liquid volumes.

Version 4.2
- Added new algorithms for "Rotation Level Bias" option. Now this option has 3 values: None, Fast and Accurate.
- [Fix] Fixed color difference between multiple and non-multiple styles when in Linear Color Space

Version 4.1
- Added new detail level: "Simple No Flask"
- Added "Use Light Color" option (refers to directional light)
- Added option to disable noise to improve performance on lower end devices
- [Fix] Fixed empty slot issue in materials list when switching prefab mode

Version 4.0.5
- Memory and loading optimizations when using many instances of same flask
- [Fix] Fixed an issue with Unity 2021.2 that affects shader variants in a build

Version 4.0.4
- Memory optimizations for bubbles option

Version 4.0.3
- [Fix] Fixed specular visible in objects without flasks

Version 4.0.2
- [Fix] Fixed flask mesh being partially visible when refraction blur is enabled on non-flask types

Version 4.0.1
- [Fix] Fixed miscible amount calculation bug

Version 4.0
- First version compatible with URP


License information
-------------------
- Liquid Volume developed by Ramiro Oliva @Kronnect.
- If purchased on the Asset Store, this asset is subjet to Asset Store EULA (https://unity3d.com/es/legal/as_terms). 
- If purchased on other site, Liqud Volume is licensed under specific terms by you and (C) 2018-2021 Ramiro Oliva
- Uses LiquidVolumeFX.MIConvexHull library (MIT license) for the Fix Mesh feature