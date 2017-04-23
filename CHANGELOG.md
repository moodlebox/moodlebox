# MoodleBox Release notes

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Version 1.6.4, 2017-04-11

* Based on Raspbian Jessie Lite version of 2017-04-10
* Uses now last released version of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle

## Version 1.6.3, 2017-03-25

* Updated to Moodle 3.2.2
* Description on front page now uses localisation
* Better memory usage
* InnoDB parameters tweaks for small performance improvements

## Version 1.6.2, 2017-03-10

* Uses now MariaDB 10.1.21
* Better cleanup, for a smaller disk image
* Other minor fixes

## Version 1.6.1, 2017-03-04

* Based on Raspbian Jessie Lite version of 2017-03-02
* MariaDB default character encoding and collation updated (see issue [MDL-48228](https://tracker.moodle.org/browse/MDL-48228))

## Version 1.6, 2017-02-27

* Based on Raspbian Jessie Lite version of 2017-02-16
* Uses now PHP7, for a 30% performance improvement :-)

## Version 1.5.1, 2017-02-11

* Prevent side effects after renaming the default user (symbolic link added)
* Updated package installation ordering

## Version 1.5, 2017-01-31

* Updated to Moodle 3.2.1
* APCu cache module for PHP installed

## Version 1.4.1, 2017-01-11

* Based on Raspbian Jessie Lite version of 2017-01-11
* Updated to Moodle 3.1.4

## Version 1.4, 2016-12-21

* Added automatic filesystem resizing at first boot

## Version 1.3.6, 2016-12-07

* Augmentation of maximum script execution time
* Uses version 1.4.3 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.
* Minor fixes

## Version 1.3.5, 2016-12-01

* Based on Raspbian Jessie Lite version of 2016-11-25
* Update of documentation
* Minor fixes

## Version 1.3.4, 2016-11-04

* Download Moodle with a shallow git clone, reducing dramatically the image size
* Minor cleanup enhancements

## Version 1.3.3, 2016-10-27

* Based now on Raspbian Jessie Lite version of 2016-09-23
* Fix to Wi-Fi configuration, enabling channel 12 and 13 if needed
* Wi-Fi access point channel changed
* Minor fixes to potential installation hiccups

## Version 1.3.2, 2016-09-18

* Updated to version 1.4 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.
* No other new features.

## Version 1.3.1, 2016-09-10

* Updated to version 1.3 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.
* No other new features.

## Version 1.3, 2016-08-21

* Local DNS provided, enabling every device (with or without zeroconf) to access the MoodleBox via the FQDN `moodlebox.home`.
* Moodle URL changed from `moodlebox.local` to `moodlebox.home`; the old URL redirects to the new one.

## Version 1.2.1, 2016-08-20

* Changed database from MySQL to MariaDB, version 10.0.26.

## Version 1.2, 2016-08-11

* Updated to version 1.2 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.
* No other new features.

## Version 1.1.1, 2016-08-09

* Documentation Updated.
* Scripts to build the MoodleBox enhanced and updated.

## Version 1.1, 2016-08-06

* Updated to version 1.1 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This version adds display of free space on SD card of the MoodleBox.
* Added advertising of mDNS services (Avahi service file created).

## Version 1.0, 2016-07-11

* Updated to Moodle 3.1.1.
* Updated to version 1.0 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This version adds a time setting feature for the MoodleBox.
* First publication of scripts to build the MoodleBox.

## Version 1.0b (beta), 2016-06-26

* Two temporary folders configured as RAM disks, for much better performance (see [this forum discussion on moodle.org](https://moodle.org/mod/forum/discuss.php?d=335066#p1350156)).

## Version 1.0a2 (alpha), 2016-06-19

* Reorganisation of the project.
* Updated to version 1.0a2 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

## Version 1.0a1 (alpha), 2016-06-16

* Installation of a preliminary version (1.0a1) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This plugin helps the administrator of the MoodleBox to monitor some hardware settings and allows restart and shutdown of the MoodleBox via GUI.

## Version 0.4 (pre-release), 2016-06-04

* The Moodle platform is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/).

## Version 0.3 (pre-release), 2016-05-29

* Updated to Moodle 3.1.
* Default account for SSH is now _moodlebox_ (instead of _pi_). Password is unchanged: _Moodlebox4$_.

## Version 0.2 (pre-release), 2016-05-19

* When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
* Option to upload files on the MoodleBox via SFTP (username: _moodlebox_, password: _Moodlebox4$_); these files are available for the admins and teachers of the Moodle server, via a _File system_ repository.

## Version 0.1 (pre-release), 2016-04-13 (first version)

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
