# MoodleBox

A project to build a Moodle server and Wi-Fi router on a Raspberry Pi 3.

The documentation is included in the `doc` folder, as a LaTeX document (in french; sorry, no english version as of now, pull request highly desirable).

## Features of the MoodleBox

* MoodleBox hostname is _moodlebox_. It's reachable on the local network with FQDN _moodlebox.home_. Access via SSH is enabled on port 22 ; username: _moodlebox_, password: _Moodlebox4$_ (e.g. `ssh moodlebox@moodlebox.home`).
* Wi-Fi access point. SSID: _MoodleBox_; password: _moodlebox_.
* Internet access: when the MoodleBox is connected via ethernet to a network connected to Internet, the MoodleBox acts as a router (IP forwarding) and the Wi-Fi clients have access to Internet.
* Moodle 3.2.x LMS reachable via Wi-Fi (or ethernet, see below), URL: [http://moodlebox.home/](http://moodlebox.home/); standard configuration of Moodle with no customisation. An admin account for the Moodle, username: _admin_, password: _Moodlebox4$_. The Moodle server is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/). The maximal size of uploaded files is set to 50Mb. The cron is launched every 3 minutes.
* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* GUI to restart and shutdown the MoodleBox.
* GUI to change the password of the MoodleBox.
* GUI to change the password of the Wi-Fi network published by the MoodleBox.
* GUI to set date and time of the MoodleBox (when away from Internet connection).
* [PhpMyAdmin](http://moodlebox.home/phpmyadmin) is installed with an admin account; username: _root_, password: _Moodlebox4$_.

## Building the MoodleBox

To build a MoodleBox from scratch with this script, you need a Raspberri Pi 3 (Wi-Fi!) and follow these instructions.

1. Clone Rasbpian Jessie Lite on your microSD card
1. Create a `ssh` file on the `boot` partition, e.g. `touch ssh`
1. Login to your RPi with the default user pi: `ssh pi@raspberrypi.local`
1. Upgrade your Raspbian installation: `sudo apt-get update && sudo apt-get dist-upgrade -y`
1. Install `rsync`: `sudo apt-get install rsync`, then logout
1. Prepare a file `authorized_keys` containing your public keys
1. Launch `bash copy-sshkeys-to-rpi.sh` and enter the pi user default password (`raspberry`)
1. Login to your RPi with the user root (no password required): `ssh root@raspberrypi.local`
1. Launch `curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | sudo bash`

### Building the MoodleBox manually

To build a MoodleBox manually, follow the [instructions given in the documentation](https://github.com/martignoni/make-moodlebox/blob/master/doc/Moodlebox.pdf) (in french).

## Usage of the MoodleBox

Read the [user manual](https://moodle.org/mod/book/view.php?id=8265), in french.

## Availability

The code is available at [https://github.com/martignoni/make-moodlebox](https://github.com/martignoni/make-moodlebox).

A [prepared disk image](https://moodlebox.net/en/dl) of the latest released version is [available for downloading](https://moodlebox.net/en/dl), cloning on your microSD card and using out of the box on your Raspberry Pi 3.

### Release notes

#### Version 1.5.1, 2017-02-11

* Prevent side effects after renaming the default user (symbolic link added)
* Updated package installation ordering

#### Version 1.5, 2017-01-31

* Updated to Moodle 3.2.1
* APCu cache module for PHP installed

#### Version 1.4.1, 2017-01-11

* Based on Raspbian Jessie Lite version of 2017-01-11
* Updated to Moodle 3.1.4

#### Version 1.4, 2016-12-21

* Added automatic filesystem resizing at first boot

#### Version 1.3.6, 2016-12-07

* Augmentation of maximum script execution time
* Uses version 1.4.3 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle.
* Minor fixes

#### Version 1.3.5, 2016-12-01

* Based on Raspbian Jessie Lite version of 2016-11-25
* Update of documentation
* Minor fixes

#### Version 1.3.4, 2016-11-04

* Download Moodle with a shallow git clone, reducing dramatically the image size
* Minor cleanup enhancements

#### Version 1.3.3, 2016-10-27

* Based now on Raspbian Jessie Lite version of 2016-09-23
* Fix to Wi-Fi configuration, enabling channel 12 and 13 if needed
* Wi-Fi access point channel changed
* Minor fixes to potential installation hiccups

#### Version 1.3.2, 2016-09-18

* Updated to version 1.4 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle.
* No other new features.

#### Version 1.3.1, 2016-09-10

* Updated to version 1.3 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle.
* No other new features.

#### Version 1.3, 2016-08-21

* Local DNS provided, enabling every device (with or without zeroconf) to access the MoodleBox via the FQDN `moodlebox.home`.
* Moodle URL changed from `moodlebox.local` to `moodlebox.home`; the old URL redirects to the new one.

#### Version 1.2.1, 2016-08-20

* Changed database from MySQL to MariaDB, version 10.0.26.

#### Version 1.2, 2016-08-11

* Updated to version 1.2 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle.
* No other new features.

#### Version 1.1.1, 2016-08-09

* Documentation Updated.
* Scripts to build the MoodleBox enhanced and updated.

#### Version 1.1, 2016-08-06

* Updated to version 1.1 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle. This version adds display of free space on SD card of the MoodleBox.
* Added advertising of mDNS services (Avahi service file created).

#### Version 1.0, 2016-07-11

* Updated to Moodle 3.1.1.
* Updated to version 1.0 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle. This version adds a time setting feature for the MoodleBox.
* First publication of scripts to build the MoodleBox.

#### Version 1.0b (beta), 2016-06-26

* Two temporary folders configured as RAM disks, for much better performance (see [this forum discussion on moodle.org](https://moodle.org/mod/forum/discuss.php?d=335066#p1350156)).

#### Version 1.0a2 (alpha), 2016-06-19

* Reorganisation of the project.
* Updated to version 1.0a2 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle.

#### Version 1.0a1 (alpha), 2016-06-16

* Installation of a preliminary version (1.0a1) of the [MoodleBox plugin](https://github.com/martignoni/moodlebox-plugin) for Moodle. This plugin helps the administrator of the MoodleBox to monitor some hardware settings and allows restart and shutdown of the MoodleBox via GUI.

#### Version 0.4 (pre-release), 2016-06-04

* The Moodle platform is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/).

#### Version 0.3 (pre-release), 2016-05-29

* Updated to Moodle 3.1.
* Default account for SSH is now _moodlebox_ (instead of _pi_). Password is unchanged: _Moodlebox4$_.

#### Version 0.2 (pre-release), 2016-05-19

* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* Option to upload files on the MoodleBox via SFTP (username: _moodlebox_, password: _Moodlebox4$_); these files are available for the admins and teachers of the Moodle server, via a _File system_ repository.

#### Version 0.1 (pre-release), 2016-04-13 (first version)

* The MoodleBox can be reached via SSH, username: _pi_, password: _Moodlebox4$_.
* The MoodleBox acts as a Wi-Fi access point. SSID: _MoodleBox_; password: _moodlebox_.;
* Moodle 3.0 installed on PHP 5.6.24, nginx 1.6.2 and MySQL 5.5.50 is accessible using the URL [http://moodlebox.local/](http://moodlebox.local/); standard configuration of Moodle with no customisation. An admin account for the Moodle, username: _admin_, password: _Moodlebox4$_.
* The maximal size of uploaded files in Moodle is set to 50Mb.
* The Moodle cron is launched every 3 minutes.
* Internet access: when the MoodleBox is connected via ethernet to a network connected to Internet, the MoodleBox acts as a router (IP forwarding) and the Wi-Fi clients have access to Internet.
* [PhpMyAdmin](http://moodlebox.local/phpmyadmin) is installed with an admin account; username: _root_, password: _Moodlebox4$_.
* RAM disk for `/var/cache/moodle`.
* No mail server, since the MoodleBox intended use is outside of any connection.
* Built on Raspbian Jessie Lite.

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


