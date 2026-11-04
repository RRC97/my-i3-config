#!/usr/bin/env bash

# Kill running bars
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch one bar per monitor
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/polybar"

mkdir -p "$state_dir"

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [[ $m == "VGA-A-0" ]]; then
        MONITOR=$m polybar --reload secondary -c $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a "$state_dir/polybar2.log" & disown 
    else
        MONITOR=$m polybar --reload main -c $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a "$state_dir/polybar1.log" & disown 
    fi
done


