#!/bin/bash

export DISPLAY=:0 #very important if you want to be runned by a cron job

current_hour=$(date +"%k")

# Defining the disable_screensaver function
function disable_screensaver {
    # Disabling sleep time
    # 0 value will never turn the screen off; you can change this value as you wish:
    # for example to turn the screen of after 10 min, use 600
    gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-display-battery 0
    gsettings set org.gnome.desktop.session idle-delay 0
}

# Defining the enable_screensaver function
function enable_screensaver {
    # Enabling sleep time to 1 second
    gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 1
    gsettings set org.gnome.settings-daemon.plugins.power sleep-display-battery 1
    gsettings set org.gnome.desktop.session idle-delay 1

    notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "Let's go to sleep now!"
}

if [ "$current_hour" -ge "7" ] && [ "$current_hour" -lt "11" ]; then
    enable_screensaver
else
    disable_screensaver
fi

exit 0
