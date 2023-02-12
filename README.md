My personal and quick dwm setup.

Links needed:

git clone https://git.suckless.org/dwm

https://dwm.suckless.org/patches/pertag/

https://dwm.suckless.org/patches/shift-tools/ (shiftview)

##Changes to config.def.h or config.h

change borderpx to 0

change topbar to 0

change color_gray1 to #0c0c0c

change color_gray3 to #ffffff

change color_gray4 to #ffffff

change color_cyan to #414141

#rules

add or change rules: Vivaldi-stable, mpv, Steam, corectrl, scratchpad

#layout

change mfact from 0.55 from 0.50

change resizehints to 0

#key definitions

change Mod1Mask to Mod4Mask for MODKEY

#add shiftview.c in proper location
 
#include "shiftview.c"

static const Key keys[] = {

#add binds

    { MODKEY,                       XK_comma,  shiftview,      {.i = -1 } },
    { MODKEY,                       XK_period, shiftview,      {.i = +1 } },

#patch in pertag

patch -p1 < dwm-pertag-20200914-61bb8b2.diff 


make

sudo make clean install  
