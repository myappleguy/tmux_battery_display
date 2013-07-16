##Tmux Battery Status Display

Charging:![Charging](pics/charging.png)
On Battery Power:![On Battery](pics/on_battery.png)
Full Charge on Battery Power:![Full on Battery](pics/full_on_battery.png)
Full on AC:![Full on AC](pics/full_on_ac.png)

Just add this to your `.tmux.conf` in the `status-left` or `status-right` and pipe it `pmset -g batt` like this.

`set -g status-left "#(pmset -g batt | ~/bin/battery_hearts.rb)"`
