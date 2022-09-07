# Enable Ctrl-Alt-Bksp to drop to console. 
setxkbmap -option terminate:ctrl_alt_bksp

# use trackball mouse to scroll when FN3 is held. 
xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Button Scrolling Button' 12
xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Scroll Method Enabled' 0 0 1

# Turn off sleep, and screensaver
xset -dpms 
xset s off

xrandr --dpi 112
xrandr --dpi 112

xrdb -merge ~/.Xresources

sleep 1 &&  nitrogen --set-scaled --save $HOME/.fluxbox/backgrounds/monochrome-street-lights-1920×1080.jpg

conky &
xbindkeys &
synergys &

exec startfluxbox

