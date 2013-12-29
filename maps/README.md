UrT Map development repository
=====
Source assets of community developed maps are stored here for anyone to build on or with.

*FAQ #1*: Isn't the repo going to get huge, by storing all those maps?  
A: NO. Map packages (pk3) are hosted elsewhere, with a specified d/l location in the map's readme document. Map assets in development are committed to the mapdev repo.

*FAQ #2*: How do I commit files to the depo?  
A: You must have a GitHub account. Then favorite/follow this repo. Access will be granted by wily, and you'll have full ability to manage any assets here. The process for using git to commit files is located in the [HOWTO.md](../HOWTO.md) document.

How this works
-----
The repo contains assets in development, for development. It is not a depo to dump unarchived pk3's. This is not a dropbox.

There is structure and order in this depo. Everyone else is counting on you to maintain efficiency with assets. If you commit a pile of files, all contributors feel that burden.

It would be advisable to become acquainted with the [CMM community](http://www.custommapmakers.org/). They're very hospitable, and are supportive to this repo.

Behaviors
-----
Two maps, [vanilla](vanilla) and [darkwater](darkwater), are the current poster example maps of how map development should behave in this repo. There are some growing pains while we standardize the process.

Baseline: include a url of your pk3 asset in the README.md (or .txt) file, giving a d/l where the bulk of the map content can be downloaded. Commit changes to assets here in the repo that support community development of the map.

The current process is copying the needed map files to your development environment, copying them back to the repo, committing and syncing.

*FAQ#3#: What if there's a conflict? Like someone mods a map and commits while I'm making changes?
A: Git will inform you that a conflict exists before allowing your commit.

There also exists a merging script for maps (by NulL) which will resolve such conflicts. It is located in the tools/ folder called [mapdiff](../tools/mapdiff). The tool has not been tested yet with the mapdev repo - testers welcome.

### To manually resolve a commit conflict
Steps:  

1) Save your map with a different name, like ut4_yourmap_z1.map

2) Download the newly committed map and replace your ut4_yourmap.map version with the updated version.

3) Open the new .map in Radiant. Refresh shaders, or any other assets that may have been committed.

4) Open a second instance of Radiant and open your _z1 version.

5) Select and copy your changed brushes/entities/etc

6) Carefully select the same brushes/entities from the new .map version. CAUTION: be really careful that you compare your changes to the new changes!

7) Delete the exact same selected objects from the new map version.

8) Paste your changes to the new map.

9) Save and commit the new map.


We'll streamline this process as experience is gained.
