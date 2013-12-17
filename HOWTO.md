A quick guide on git
=====

If you don't know how to use 'git', we'll get you started plenty quick. Less hacking, more doing! And more fun.

Open these [installation instructions](https://help.github.com/articles/set-up-git) in another tab. Click the ```Not sure what to pick on each screen``` button. Now you have a visual.

First, [download git](http://git-scm.com/download/win) and begin the installation.

During the installation, you will be asked to install context menu entries - I highly recommend them. When asked about adjusting your PATH, the second option ```Run git from the windows command prompt``` is recommended.

Second, [download Github for Windows](http://windows.github.com) and install.

In the installation, you'll log in or sign up (free GitHub account). Then enter a ```Name``` (alias is fine) and ```Email```. Don't worry about repositories at this stage. Almost there!

Once installed, click ```tools``` -> ```options```.  
1. Change ```default storage directory``` to an appropriate location. (repos will populate on your harddrive as familiar dirs/files) For now, budget a couple GB's for future growth when considering what folder to use.  
2. Change ```default shell``` to ```Git Bash``` (recommended)  
3. Click ```update```.  

Drag the url link for [mapdev](https://github.com/wilyphoenix/mapdev) into the resulting application window. The mapdev repo will populate into the folder destination you set above.

Git has many checks and balances for multi-user edits (commits) and thus there's a process to updating files.

The simple end of it: make modifications in windows explorer in the *destination folder*, then in GitHub for Windows, write a commit message indicating what you did, then commit, then sync. Kind of like a paranoid version of Dropbox.

Branches are really cool. A branch soft clones all files in the repo. Like having a shadow repo. You can select another branch, which causes all local files in your repo to either be created or deleted or changed to match the selected branch. Select the previous branch to put everything the way it was. Make a new branch to have your own variation on the repo's content, without affecting the main content.

Try selecting a different branch by clicking the ```master``` button with a fork-looking symbol at the top. If you watch your files in explorer while selecting a different branch, you may notice files changing! This is how branches work. All files are safe in their respective branch.

The first time you make a change to a file and try to commit it, the process may fail (sigh..) but if so, in GitHub for Windows, click the gear in the upper-right corner. Select ```open a shell here```. Type the following on the command line.

    git fetch --all
    git pull https://github.com/wilyphoenix/mapdev
    git push --set-upstream origin master
    
You may be asked for your user and password to connect to the repo. Once this process is complete, you shouldn't have to do this again as the configuration files required are now in place.

When writing markdown code like this HOWTO.md file, the following links are useful.  

[Markdown format basics](http://daringfireball.net/projects/markdown/basics)  
[GitHub Markdown, markdown extension](https://help.github.com/articles/github-flavored-markdown)  


