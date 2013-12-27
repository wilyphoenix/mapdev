Mapdev repo, not depo
=====
This description/readme will be greatly updated soon with much more thorough information.

How this works
-----
The repo contains assets in development, for development. It is not a depo to dump unarchived pk3's.

Two maps, vanilla and darkwater, are the current poster example maps of how map development should behave in this repo. There are some growing pains while we standardize the process. Baseline: include a url of your pk3 asset in the README.md (or .txt) file where the bulk of the content can be downloaded, then commit changes to assets here in the repo that support community development of the map.

The current process is copying the needed map files to your development environment, copying them back to the repo, committing and syncing.

Conflicts
-----
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
