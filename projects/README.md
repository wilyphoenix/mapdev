UrT Map development repository
=====
Source assets of community developed maps are stored here for anyone to build on or with. This is a live developers' environment. We keep relevant content in the repo that is beneficial to mappers, amateur and experienced alike.

*FAQ #1*: Isn't the repo going to get huge, by storing all those maps?  
A: NO. Map packages (pk3) are hosted elsewhere, with a specified download location described in the map's readme document. Map assets in development are committed to the mapdev repo.

*FAQ #2*: How do I commit files to the depo?  
A: You must have a GitHub account. Then favorite/follow this repo. Access will be granted by wily, and you'll have full ability to manage any assets here. The process for using git to commit files is located in the [HOWTO.md](../HOWTO.md) document.

How this works
-----
The repo contains assets in development, for development. It is not a depo to dump unarchived pk3's. This is not a dropbox.

There is structure and order in this depo. Everyone else is counting on you to maintain efficiency with assets. If you commit a pile of files, all contributors feel that burden.

It would be advisable to become acquainted with the [CMM community](http://www.custommapmakers.org/). They're very hospitable, and are supportive to this repo.

Starting a project
-----
A map project in the repo begins with the following assets:  

    1. PROJECT README: [yourmap] / README.md
    2. MAP README:     [yourmap] / ut4_[yourmap]_README.txt
    3. MAP SOURCE:     [yourmap] / maps / ut4_[yourmap].map
    4. PREVIEW IMAGE:  [yourmap] / [yourmap]_preview.jpg

The project readme is a markdown-formatted file that first appears in the project folder under the assets, like this one. It includes the projects' immediate need-to-know information.

The map readme consists of a readme file that was or will be included with the release pk3. This does not have to be complete at this time if the map pk3 has not released.

The map source is the .map file in the projects' current development state.

The preview image is a simple screenshot of the map, with the following attributes:  
 - 800x500, or 800px width and height of the original aspect ratio of the screenshot
 - jpeg format
 - ~100k

Structure
-----
Maps themselves are considered projects. Thus, no prefix will be used, such as "ut4_". The structure is identical to a standard q3ut4 directory, with additional resource and asset directories as required.

`[project] / [resource] / [asset]`

Example:  
`vanilla / maps / ut4_vanilla.map`

and as an asset group:  
`vanilla / textures / ut4_vanilla / whitegrid-32px.tga`

This should be completely familiar to any seasoned UrT (or idtech3) mapper or dev.


Behaviors
-----
Two maps, [vanilla](vanilla) and [darkwater](darkwater), are the current poster example maps of how map development should behave in this repo. There are some growing pains while we standardize the process.

Baseline: include a url of your pk3 asset in the README.md (or .txt) file, giving a download url where the bulk of the map content can be downloaded. Commit changes to assets here in the repo that support community development of the map.

The current process is copying the needed map files to your development environment, copying them back to the repo, committing and syncing.

*FAQ#3#: What if there's a conflict? Like someone mods a map and commits while I'm making changes?  
A: Git will inform you that a conflict exists before allowing your commit.

There also exists a merging script for maps (by NulL) which will resolve such conflicts. It is located in the tools/ folder called [mapdiff](../tools/mapdiff). The tool has not been tested yet with the mapdev repo. CMM has a [wiki page](http://www.custommapmakers.org/wiki/index.php/Compiling:Makefiles#Multimapping_-_Diff.2FMerge_on_maps) that describes this tool further.

Mapdev via git
-----
When using the git system to share the development load, one has to be mindful of their fellow developers.



### Manually resolve a commit conflict
It's possible that someone updated a file and committed it, while you were working on the same file. Here's a process that can help work through a .map commit that's in jeopardy of losing recent edits by another user.  

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
