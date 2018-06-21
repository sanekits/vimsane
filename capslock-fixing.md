# Fixing CAPSLOCK 

CAPSLOCK is Evil, particularly if you're a `vim` user.  

## On Windows:
*If* you have administrator access on Windows 7 for a PC, you can modify the registry to [remap the CAPSLOCK key to CTRL](https://commons.lbl.gov/display/~jwelcher@lbl.gov/Making+Caps+Lock+a+Control+Key), which is the most
sensible solution.  

*But:* during training, or when using machines in the training rooms where you cannot get administrator access, you can still solve the
problem using `uncap.exe`:

1. `Start > Run >` and type `regedit`.
1. Drill into the tree, until you get to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`
1. Right-click in the right-side pane, choose `New > String Value`
1. Edit the `Name` field. *(You can call it whatever you like, "uncap" is suggested)*
1. Double-click the new entry you created, and paste this into the Value data: 
`u:\lmatheson4\uncap.exe 0x14:0xa2`
1. Log off Windows and log in again.
