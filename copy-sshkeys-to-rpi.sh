#!/usr/bin/env bash

# This script copies your SSH public keys to the Raspberry Pi.
# You should copy your public keys in a file named "authorized_keys",
# placed in the same directory of this script. This script
# will send the file "authorized_keys" in the adequate location of
# the root account of the Raspberry Pi. You'll have to enter the
# password of the "pi" account; default is "raspberry" (without quotes).

# rsync should be installed on the RPi before running this script.
# ssh into your RPi and launch sudo apt-get install rsync

# The very folder where this script is stored
SELFDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Default key file
DEFAULTKEYFILE=$SELFDIR/authorized_keys

# These are my personal public keys.
# cat << "EOF" > $DEFAULTKEYFILE
# ssh-dss AAAAB3NzaC1kc3MAAACBANUzp1IPYgFP6GqnmIjtW7IRL0Wakn8TDD12nLNTEtyz6anGcuuuP6VyZIw0lLEKMf3Al+9j+u4dP66o7xwLtm1vvqtgKppEf+Yo9isb50Jj6dXIB3kYpmcWseV5qtQX78Yui7+DXHZ8ow6zxXbTHzx+mdMJm4ebLQbdLpAhRRHLAAAAFQDzz4F+03vlY5lPVT9ZLsA/MBcCoQAAAIBz5FEnqAMwzQekk7Ljr+yuIcYMBS974nJzT9ZcJoXVEL/uhVvzRiprFrID1/7DwruIXAJSImHW34jwqCGoSHj0fkCcsHIh/KOuJOwGaRbbW3kfIu4+1yZoQovQdxREjTLEJSKBLqEghRB+RcDRp38yHfUfi3kfDWOPYbULO0sNsgAAAIEAs8MTEMOZtke8ICfL3KyV3wprBrUEG3H4QhqsJWdYVU7Y/0XZ6fN9YOWFNAs94MYg/b/RnPT5kRqXq3u5NttMfgg7gnV7Xuh0ik7HtOd5D4uM+o0Xyq+j/eBqxXSizaapDvspkkhFcOtSSf2hZdeHpKvan+PaKmpBm0Vx8PhKgAo= nicolas@Martignoni.local.
# ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAkfAVq+GubMYwgEktSbJJJDcqr7GvJ4nJS6wDVkjeHGVqIt0LqsJMHTdSexT6mglu/3A2nIozyc3VkK1XKsfg821HsupTV6cdDp7dRuysxkJfV3FRq3dV6X3ohY/fO7QYtkAHPjYqss5hr+Fs6uUGU8PbMpcsT+E6CktZenETUR0= nicolas@Martignoni.local.
# EOF

# Set $KEYFILE to the value of the first argument given to the script.
# If first argument is missing, set it to $DEFAULTKEYFILE
KEYFILE=${1:-$DEFAULTKEYFILE}

[ -f $SELFDIR/authorized_keys ] || { echo 'Key file not found. Please copy your "authorized_keys" file in this directory and try again.'; exit 1; }

# Key file found, script start!

# Copy SSH keys to root account using rsync
# http://superuser.com/questions/270911/run-rsync-with-root-permission-on-remote-machine
rsync -rlptDqz -e ssh --rsync-path="echo mypassword | sudo -S mkdir -p /root/.ssh && sudo rsync" --include='/authorized_keys' --exclude='*' ./ pi@raspberrypi.local:/root/.ssh/

# The end