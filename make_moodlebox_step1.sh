#!/usr/bin/env bash
# This script MUST be run as root

# ### Step 1 : login as pi user and enable root access via SSH, using key-based authentication

# ssh pi@raspberrypi.local

sudo mkdir /root/.ssh/
sudo cat << "EOF" > /root/.ssh/authorized_keys
ssh-dss AAAAB3NzaC1kc3MAAACBANUzp1IPYgFP6GqnmIjtW7IRL0Wakn8TDD12nLNTEtyz6anGcuuuP6VyZIw0lLEKMf3Al+9j+u4dP66o7xwLtm1vvqtgKppEf+Yo9isb50Jj6dXIB3kYpmcWseV5qtQX78Yui7+DXHZ8ow6zxXbTHzx+mdMJm4ebLQbdLpAhRRHLAAAAFQDzz4F+03vlY5lPVT9ZLsA/MBcCoQAAAIBz5FEnqAMwzQekk7Ljr+yuIcYMBS974nJzT9ZcJoXVEL/uhVvzRiprFrID1/7DwruIXAJSImHW34jwqCGoSHj0fkCcsHIh/KOuJOwGaRbbW3kfIu4+1yZoQovQdxREjTLEJSKBLqEghRB+RcDRp38yHfUfi3kfDWOPYbULO0sNsgAAAIEAs8MTEMOZtke8ICfL3KyV3wprBrUEG3H4QhqsJWdYVU7Y/0XZ6fN9YOWFNAs94MYg/b/RnPT5kRqXq3u5NttMfgg7gnV7Xuh0ik7HtOd5D4uM+o0Xyq+j/eBqxXSizaapDvspkkhFcOtSSf2hZdeHpKvan+PaKmpBm0Vx8PhKgAo= nicolas@Martignoni.local.
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAkfAVq+GubMYwgEktSbJJJDcqr7GvJ4nJS6wDVkjeHGVqIt0LqsJMHTdSexT6mglu/3A2nIozyc3VkK1XKsfg821HsupTV6cdDp7dRuysxkJfV3FRq3dV6X3ohY/fO7QYtkAHPjYqss5hr+Fs6uUGU8PbMpcsT+E6CktZenETUR0= nicolas@Martignoni.local.
EOF

apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get upgrade -y
raspi-config
## Expand filesystem
## Change user password
## Change locale
## Change timezone
## Change WiFi country
## Change hostname

# reboot
#reboot

## End