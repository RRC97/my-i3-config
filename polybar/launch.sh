#!/usr/bin/env bash

# Kill running bars
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch one bar per monitor

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [[ $m == "HDMI-A-0" ]]; then
        MONITOR=$m polybar --reload secondary -c $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a /tmp/polybar2.log & disown 
    else
        MONITOR=$m polybar --reload main -c $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a /tmp/polybar1.log & disown 
    fi
done


