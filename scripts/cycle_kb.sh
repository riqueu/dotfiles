#!/usr/bin/env bash
# Cycle through RGB spectrum for keyboard backlight
# https://github.com/wessel-novacustom/clevo-keyboard/

# user to group so we can control the keyboard backlight without sudo
#sudo groupadd kbdled
#sudo usermod -aG kbdled $USER
#echo 'SUBSYSTEM=="leds", KERNEL=="rgb:kbd_backlight", RUN+="/bin/chgrp kbdled /sys/class/leds/rgb:kbd_backlight/multi_intensity", RUN+="/bin/chmod g+w /sys/class/leds/rgb:kbd_backlight/multi_intensity"' | sudo tee /etc/udev/rules.d/99-kbd-backlight.rules
#sudo udevadm control --reload
#sudo udevadm trigger
#sudo reboot

LOCK_FILE="/tmp/cycle_kb.lock"

# Ensure the lock file is removed when the script exits
trap 'rm -f "$LOCK_FILE"' EXIT

# Create the lock file and store our process ID
echo $$ > "$LOCK_FILE"

# Set step size and delay (in seconds)
STEP=15
DELAY=0.05

while true; do
    # Red to Yellow (increase G)
    for G in $(seq 0 $STEP 255); do
        echo 255 $G 0 | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
    # Yellow to Green (decrease R)
    for R in $(seq 255 -$STEP 0); do
        echo $R 255 0 | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
    # Green to Cyan (increase B)
    for B in $(seq 0 $STEP 255); do
        echo 0 255 $B | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
    # Cyan to Blue (decrease G)
    for G in $(seq 255 -$STEP 0); do
        echo 0 $G 255 | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
    # Blue to Magenta (increase R)
    for R in $(seq 0 $STEP 255); do
        echo $R 0 255 | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
    # Magenta to Red (decrease B)
    for B in $(seq 255 -$STEP 0); do
        echo 255 0 $B | tee /sys/class/leds/rgb:kbd_backlight/multi_intensity > /dev/null
        sleep $DELAY
    done
done
