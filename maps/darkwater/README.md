This is a repo for the map ut4_darkwater and its subsequent versions.

Source pk3 (release) has all current assets. Hosted location: http://digitalamusement.com/gamedev/maps/ut4_darkwater.pk3

Includes maps/ut4_darkwater.map, though it will be committed soon for immediately accessible community development.

The branch ```darkwater2_alpha``` has been deleted. All previous darkwater content was also deleted, as the hosted .pk3 contains static map assets. Upload/commit any assets that are to be part of development.

Unused assets from the original pk3 have been moved to [unused/](unused/). This is only reference at this point. Eventually, a tool/script like the versioneer will strip unused assets automatically (or perhaps your favorite pk3 packager).

The community is expressly encouraged to bring new modifications to the map. Current process is copying the needed map files to your development environment, copying them back to the repo, committing and syncing.

Conflicts
----

### What if there's a conflict? Like someone mods a map and commits while I'm making changes?
1) git will inform you that a conflict exists before allowing your commit.

2) There exists a merging script for maps (believe by NulL) which will resolve such conflicts. I'm investigating this.

### Manual conflict resolution
Steps:  

1) Save your map with a different name, like ut4_darkwater_z1.map

2) Download the newly committed map and replace your ut4_darkwater.map version with the updated version.

3) Open the new .map in Radiant. Refresh shaders, or any other assets that may have been committed.

4) Open a second instance of Radiant and open your _z1 version.

5) Select and copy your changed brushes/entities/etc

6) Carefully select the same brushes/entities from the new .map version. CAUTION: be really careful that you compare your changes to the new changes!

7) Delete the exact same selected objects from the new map version.

8) Paste your changes to the new map.

9) Save and commit the new map.


We'll streamline this process as experience is gained.
