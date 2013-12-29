A quick guide on git
=====

If you don't know how to use 'git', we'll get you started plenty quick. Less hacking, more doing! And more fun.

There are two main sections: GUI and CLI. If you have a few extra minutes, please read both sections, specifically the CLI section.

## GUI based - Windows
To get started, open these [installation instructions](https://help.github.com/articles/set-up-git) to set up git in another tab. Click the ```Not sure what to pick on each screen``` button. Now you have a visual.

First, [download git](http://git-scm.com/download/win) and begin the git installation.

During the installation, you will be asked to install context menu entries - I highly recommend them. When asked about adjusting your PATH, the second option ```Run git from the windows command prompt``` is recommended.

Once git is installed, [download Github for Windows](http://windows.github.com) and install.

In this installation, you'll log in or sign up (free GitHub account). Then enter a ```Name``` (alias is fine) and ```Email```. Don't worry about repositories at this stage. Almost there!

Once installed, click ```tools``` -> ```options```.  
1. Change ```default storage directory``` to an appropriate location. (repos will populate on your harddrive as familiar dirs/files) For now, budget a couple GB's for future growth when considering what folder to use.  
2. Change ```default shell``` to ```Git Bash``` (recommended)  
3. Click ```update```.  

Lastly, drag the url link for [mapdev](https://github.com/wilyphoenix/mapdev) into the resulting application window. The mapdev repo will populate into the folder destination you set above.

### Modifying repo content

Git has many checks and balances for multi-user edits (commits) and thus there's a process to updating files.

The simple end of it: First you'll make modifications to files from Windows Explorer in the *destination folder* specified above, via some editor. Once your changes are complete, go to your GitHub for Windows app, *write a commit message* indicating what you did, click commit, click sync, done! Git is like a paranoid version of Dropbox.

Best practices for maintaining files and folder structures are found in base sections in the repo.

#### Branches

Branches are really cool. A branch soft clones all files in the repo. Like having a shadow repo. You can select another branch, which causes all local files in your repo to either be created or deleted or changed to match the selected branch. Select the previous branch to put everything the way it was. Make a new branch to have your own variation on the repo's content, without affecting the main content.

Try selecting a different branch by clicking the ```master``` button with a fork-looking symbol at the top. If you watch your files in explorer while selecting a different branch, you may notice files changing! This is how branches work. All files are safe in their respective branch.

### Manual CLI interaction (Windows)

To acquire the repo instantly without a GUI, find a suitable local folder that mapdev/ can be cloned (or copied) into. Right click that folder, select ```git bash here```. Skip down a section to [CLI commands](#cli-commands).

If during your first commit in GitHub for Windows the process fails, using the gear button in the upper-righthand corner, open a bash shell, then run the ```CLI commands``` to sync the local repo.

### Manual CLI interaction (Unix)

You'll first need a git package, which will have specific requirements for your system. This goes for the many flavors of Linux, FreeBSD, or Solaris. Once git is installed, the process is uniform.

## CLI commands

Type the following commands to declare who you are:

    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    git config --global push.default simple

Copy all mapdev repo files to your computer:

    git clone https://github.com/wilyphoenix/mapdev/

Sync your local repo (download) any time changes to the repo happen:

    cd mapdev/
    git fetch --all
    git pull https://github.com/wilyphoenix/mapdev

Sync ALL changes you made to files (upload) by:

    git add -A
    git commit -m "insert a comment about the commit"
    git push --set-upstream origin master

You will be asked for your user and password to connect to the repo.


### Troubleshooting
Git will tell you almost exactly what you need to do next, when a git command is run, if it thinks more steps need to be taken to complete a process. Uploading, or pushing, and committing files to the repo is a common process.  

You must first gather any changes from the repo and download, or pull, them to your local system.

    git fetch --all
    git pull

Now you and the repo as it exists on the internet are on the same page - next you can push up your changes with the three-step process:
#### The Three Step Process
When you make changes to the repo, you:  
Add, Commit, Push

    git add -A
    git commit -m "insert a comment about the commit"
    git push

That number again is Add, Commit, Push.

All changed files are gathered into a little database-like file. That information is bundled and stamped for delivery. Then the bundle is sent on its way for integration into the repo.

Git CLI command quick reference
-----
This is a useful collection of git commands.  

### Git documentation
https://www.kernel.org/pub/software/scm/git/docs/git.html

### Getting content

##### Clone a repo into a local subdir
`git clone [repo_url]`

##### Pull down all changes from assigned repo
`git pull`

##### Add a new remote for your branch (see git docs)
`git remote add thisnewbranch <url>`

### Review content

##### Check out what's going on in HEAD (current branch)
`git status`

### Making changes to the repo

##### Add all new or changed files, and prune old files
    git add -A
    git add .|*  # adds but not removes
    git add -n   # dry run

##### Make a local commit before submitting upstream with a comment
`git commit -m 'insert a comment about the commit'`

##### Then send changes upstream into branch called thisbranch with tracking reference
`git push -u origin thisbranch`

### Working with branches

##### switch to branch thisbranch
`git checkout thisbranch`

##### merge branch changes into master
    git checkout master
    git merge thisbranch

##### Sync changes from server thisbranch branch to local
`git pull origin thisbranch`

### Deleting or removing stuff

##### Remove files from HEAD (current branch)
`git rm somefile`

##### Clear pending changes to HEAD
`git reset`

##### delete a branch
`git branch -d thisbranch      # or -D to dead wipe it without merging`
`git push origin :thisbranch   # delete branch on github with :`

### Caching changes

##### hold and store a branch change (for "leaving" into another branch)
    git stash
    git stash apply   # apply branch changes into current branch, keep stash
    git stash pop     # ditto, remove stash
    git stash clear   # just remove stash

### Fix or repair changes

##### reverse the 2 last changes, works n times
`git push -f origin HEAD^^:master`

##### unfuck a commit to master branch
    git branch                      # list branches for reference
    git log                         # find the last correct commit id
    git branch master-fix           # create a temp fix branch
    git reset --hard <commit_id>    # rewind to this commit
    git checkout master-fix         # switch to temp branch
    git push --force origin master  # push changes up to save rewind
    git checkout anotherbranch      # resume back to original branch
    git branch -D master-fix        # delete out the temp fix branch

## GitHub Markdown formatting
Writing a [README.md](README.md), or and .md file, requires knowledge of "markdown" formatting to render fancy headers and such. You can always edit the file to see the markdown characters in action.

When writing markdown code like this HOWTO.md file, the following links are useful:  
[Markdown format basics](http://daringfireball.net/projects/markdown/basics)  
[GitHub Markdown, markdown extension](https://help.github.com/articles/github-flavored-markdown)  

