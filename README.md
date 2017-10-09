# vimsane
User-friendlier wrapper for vim, aimed at students.

The 'vimsane' command auto-installs vimsane by doing just-in-time creation of the user's ~/.vim tree if it isn't there. 
So you can tell a new user "run vimsane" and it's all automagic.

If you have an existing  ~/.vim tree that you value, vimsane will not touch it unless you do "vimsane --update".  
In that case, 'vimsane' and 'vim' are mostly interchangeable commands.

