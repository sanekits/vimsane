# vimsane
Vimsane is a user-friendly-ish canned configuration for vim, aimed at students and new vim users: "training wheels for vim which don't cripple your ability to balance."

## This repository is just the installer:
The 'vimsane' command is on the user's PATH already, and it auto-installs vimsane by doing just-in-time creation of the user's ~/.vim tree if it isn't there. So you can tell a new user "run vimsane" and setup is safe and automagic.

If you have an existing  ~/.vim tree or ~/.vimrc that you value, vimsane will not touch it.  

## The actual vim config stuff is in the public Github:
See https://github.com/sanekits/vimsane-cfg

Note that vimsane uses the Bloomberg internet-facing http proxy to pull both the vimsane.cfg base configuration, as well as a number of popular plugins. Vimsane.cfg is open source, but vimsane (the installer) is Bloomberg-proprietary and maintained in bbgithub.

