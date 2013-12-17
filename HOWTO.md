A quick guide on git
=====

If you don't know how to use 'git', then install [Github for Windows](http://windows.github.com).

In the installation, choose Git Bash.

Once installed, create a GitHub login, drag the url link for mapdev (above) into the resulting application window to have local access to changing files in this repo. Think of it like explorer, with many checks and balances for multi-user edits (commits).

tools -> options
1. Create new account OR log in with existing GitHub account
2. Set Name and Email
3. Change 'default storage directory' to an appropriate location. (repos will populate there as dirs/files)
4. Change 'default shell' to Git Bash (recommended)


git fetch --all
git pull https://github.com/wilyphoenix/mapdev
notepad.exe file.txt
git add -A
git commit -m 'comment about what changed'
git push --set-upstream origin master

git mv dir1/dir2 ./dir2


[Markdown format basics](http://daringfireball.net/projects/markdown/basics)
[GitHub Markdown, markdown extension](https://help.github.com/articles/github-flavored-markdown)
