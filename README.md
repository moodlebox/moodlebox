# MoodleBox

A project to build a Moodle server and Wi-Fi router on a Raspberry Pi 3.

The documentation is included in the `doc` folder, as a LaTeX document (in french; sorry, no english version as of now, pull request highly desirable).

## Features of the MoodleBox

* Wi-Fi access point. SSID: _MoodleBox_; password: _moodlebox_.
* Internet access: when the MoodleBox is connected via ethernet to a network connected to Internet, the MoodleBox acts as a router (IP forwarding) and the Wi-Fi clients have access to Internet.
* Moodle 3.1.x LMS reachable via Wi-Fi (or ethernet, see below), URL: [http://moodlebox.local/](http://moodlebox.local/); standard configuration of Moodle with no customisation. An admin account for the Moodle, username: _admin_, password: _Moodlebox4$_. The Moodle server is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/). The maximal size of uploaded files is set to 50Mb. The cron is launched every 3 minutes.
* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* GUI to restart and shutdown the MoodleBox.
* GUI to set date and time of the MoodleBox (when away from Internet connection).
* [PhpMyAdmin](http://moodlebox.local/phpmyadmin) is installed with an admin account; username: _root_, password: _Moodlebox4$_.

## Building the MoodleBox

1. Clone Rasbpian Jessie Lite on your microSD card
1. Login to your RPi with the default user pi: `ssh pi@raspberrypi.local`
1. Install `rsync`: `sudo apt-get install rsync`, then logout
1. Prepare a file `authorized_keys` containing your public keys
1. Launch `bash copy-sshkeys-to-rpi.sh` and enter the pi user default password
1. Login to your RPi with the user root (no password required): `ssh root@raspberrypi.local`
1. Launch `curl -L https://raw.githubusercontent.com/martignoni/make-moodlebox/master/make_moodlebox.sh | sudo bash`

## Usage of the MoodleBox

Read the [user manual](https://moodle.org/mod/book/view.php?id=8265), in french.

## Availability

The code is available at [https://github.com/martignoni/make-moodlebox](https://github.com/martignoni/make-moodlebox).

An [prepared disk image](https://moodle.org/mod/url/view.php?id=8269) of the latest released version is [available for downloading](https://moodle.org/mod/url/view.php?id=8269), cloning on your microSD card and using out of the box on your Raspberry Pi 3.

SHA1 fingerprint of the current compressed disk image (moodlebox.img.gz): 44c699a91c39c204dfe4ee4944f54627cd76c151

### Release notes

#### Version 1.1, 2016-08-06

* Updated to version 1.1 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox) for Moodle. This version adds display of free space on SD card of the MoodleBox.
* Added advertising of mDNS services (Avahi service file created).

#### Version 1.0, 2016-07-11

* Updated to Moodle 3.1.1.
* Updated to version 1.0 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox) for Moodle. This version adds a time setting feature for the MoodleBox.

#### Version 1.0b (beta), 2016-06-26

* Two temporary folders configured as RAM disks, for much better performance (see [this forum discussion on moodle.org](https://moodle.org/mod/forum/discuss.php?d=335066#p1350156)).

#### Version 1.0a2 (alpha), 2016-06-19

* Reorganisation of the project
* Updated to version 1.0a2 of the [MoodleBox plugin](https://github.com/martignoni/moodlebox) for Moodle.

#### Version 1.0a1 (alpha), 2016-06-16

* Installation of a preliminary version (1.0a1) of the [MoodleBox plugin](https://github.com/martignoni/moodlebox) for Moodle. This local plugin helps the administrator of the MoodleBox to monitor some hardware settings and allows restart and shutdown of the MoodleBox via GUI.

#### Version 0.8 (pre-release), 2016-06-04

* The Moodle server is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/).

#### Version 0.7 (pre-release), 2016-05-29

* Updated to Moodle 3.1.
* Default account for SSH is now _moodlebox_ (instead of _pi_). Password is unchanged: _Moodlebox4$_.

#### Version 0.6 (pre-release), 2016-05-19

* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* Option to upload files on the MoodleBox via SFTP (username: _moodlebox_, password: _Moodlebox4$_); these files are available for the admins and teachers of the Moodle server, via a _File system_ repository.

#### Version 0.5 (pre-release), 2016-04-13 (first version)

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

## Building and installation

To build a MoodleBox from scratch, you need a Raspberri Pi 3 (Wi-Fi!) and follow the [instructions given in the documentation](https://github.com/martignoni/make-moodlebox/blob/master/doc/Moodlebox.pdf) (in french).

The local plugin needs to be installed in the Moodle tree of the MoodleBox, in the _local_ folder. Once installed, an new option _MoodleBox administration_ will be available in Moodle, under _Site administration > Server_ in the _Administration_ block.

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


