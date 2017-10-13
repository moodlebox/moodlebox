# MoodleBox

A project to build a Moodle server and Wi-Fi router on a Raspberry Pi 3.

## How to use a MoodleBox

Visit the [MoodleBox web site](https://moodlebox.net) for any question about the usage of a MoodleBox.

## Features of the MoodleBox

* MoodleBox hostname is _moodlebox_. It's reachable on the local network with FQDN _moodlebox.home_. Access via SSH is enabled on port 22 ; username: _moodlebox_, password: _Moodlebox4$_ (e.g. `ssh moodlebox@moodlebox.home`).
* Wi-Fi access point. SSID: _MoodleBox_; password: _moodlebox_.
* Internet access: when the MoodleBox is connected via ethernet to a network connected to Internet, the MoodleBox acts as a router (IP forwarding) and the Wi-Fi clients have access to Internet.
* Moodle 3.3.x LMS reachable via Wi-Fi (or ethernet, see below), URL: [http://moodlebox.home/](http://moodlebox.home/); standard configuration of Moodle with no customisation. An admin account for the Moodle, username: _admin_, password: _Moodlebox4$_. The Moodle server is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/). The maximal size of uploaded files is set to 50Mb. The cron is launched every 3 minutes.
* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* Integrated in Moodle administration interface ([MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox)):
  * GUI to restart and shutdown the MoodleBox.
  * GUI to change the password of the MoodleBox.
  * GUI to change the password of the Wi-Fi network published by the MoodleBox.
  * GUI to set date and time of the MoodleBox (when away from Internet connection).
* [PhpMyAdmin](http://moodlebox.home/phpmyadmin) is installed with an admin account; username: _moodlebox_, password: _Moodlebox4$_.

## Building the MoodleBox

To build a MoodleBox from scratch with this script, you need a Raspberri Pi 3 (Wi-Fi!) and follow these instructions.

1. Clone Rasbpian Stretch Lite on your microSD card
1. Create a `ssh` file on the `boot` partition, e.g. `touch ssh`
1. Start your RPi and log into it with the default user pi: `ssh pi@raspberrypi.local` (password: `raspberry`)
1. Upgrade your Raspbian installation: `sudo apt-get update && sudo apt-get dist-upgrade -y`
1. Prepare a file `authorized_keys` containing your public keys
1. Launch `bash copy-sshkeys-to-rpi.sh` and enter the pi user default password (`raspberry`)
1. Login to your RPi with the user root (no password required): `ssh root@raspberrypi.local`
1. Launch `curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | bash`

## Availability

The code is available at [https://github.com/martignoni/make-moodlebox](https://github.com/martignoni/make-moodlebox).

A [prepared disk image](https://moodlebox.net/en/dl) of the latest released version is [available for downloading](https://moodlebox.net/en/dl), cloning on your microSD card and using out of the box on your Raspberry Pi 3.

### Release notes

See [Release notes](https://github.com/martignoni/make-moodlebox/blob/master/CHANGELOG.md).

## Thanks

* To Daniel Méthot, for the [idea of a MoodleBox](https://moodle.org/mod/forum/discuss.php?d=278493)
* To Christian Westphal, for the [first POC](https://moodle.org/mod/forum/discuss.php?d=331170) of a MoodleBox
* To the [Raspberry Pi Foundation](https://www.raspberrypi.org/), for a splendid small computer
* To [Martin Dougiamas](https://en.wikipedia.org/wiki/Martin_Dougiamas), for giving us Moodle, and to the [Moodle community](https://moodle.org/)

## License

Copyright © 2016 onwards, Nicolas Martignoni <nicolas@martignoni.net>

* All the source code is licensed under GPL 3 or any later version
* The documentation is licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.


