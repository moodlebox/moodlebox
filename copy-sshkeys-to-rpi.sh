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

# This is my personal public key.
# cat << "EOF" > $DEFAULTKEYFILE
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC079Tammp9qcjhQ2PhFqJvvX0hqogk9fsE0hQwUEl2TswSyTUFyijEE/oJxkERdBPmcVofEfTk7aDTfNOoRQaHpgRYHzWh3B7cs5zfmd8H8vptwb8zRHiTD77nIE55aA1XEBTDnYJ9RJI77xgPV7xKR/G1syz14jEEoIjW3irBSUc3S2UWBS5uctlWv31/+cVrOf6NcJ+FZXGMCkllT+za7r7T6RNI8i+1dg9vAebfJ7VIUOlA2vJquBmH72KP49c7vOqlyNIwZ5UlOv5txe+HHWUn2f34D/i2qFXQKn+wKsTFSf/QJdNXtDYsgE+/cS04PKumhXyqz5Tt5qenpx+8KUi+urafddf+4Wqa6LOENuAASRwNg3Y66lrho2TLK/XMaPRe9SJI2jjkM6bRizzkTykvzk/r22Nk/I9XsPTqOKGnMiBZFP+tggwZHPKhfGZPDe6ZpBx9t1UgKpr6UXnNHdxQTU0pMBYmSyBqSsalHAPpKGA1Nzrpk9bLpcUyk05apxfokO+391LGA1hF/4/p8pFnxW2jijLYTQ1/x/x1Pj4wEG3lE1BDrly621OFvZ8VoJhMntVez3z5UNwHGhCcM0VXHvRYr7UXGmROwzNd4otphpuCzVgCryYNVn4n/YRvw4+CFcAHx0PA6MAyGOrZeoB/8T/loCU6bE0L2Mqn3Q== nicolas@martignoni.net
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