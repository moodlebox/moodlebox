# MoodleBox – Release notes

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and follow principles of [keep a changelog](http://keepachangelog.com).

## Version 2.5.1, 2018-10-13
### Changed
- Based on Raspbian Stretch Lite version of 2018-10-09 (issue #91).
- Updated to [version v1.12.1](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.12.1) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #93).
- Directory permissions of Moodle source directory updated, to enable direct update of the Moodle installation without Git (issue #92).
- Temporary storage settings cleaned up.

### Fixed
- MathJax library URL is now relative. No more change needed if the domain name of the MoodleBox is changed (issue #89).
- Some image file sizes reduced.


## Version 2.5.0, 2018-08-16
### Changed
- Updated to [version v1.12.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.12.0) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #84).
- MathJax library updated to [version v2.7.5](https://github.com/mathjax/MathJax/releases/tag/2.7.5) (issue #87).
- Prevent wrong change of database password from within phpMyAdmin (issue #85).
- Tasks re-ordered and reboot added (issue #82).

### Added
- Add sudoers file to allow new feature of MoodleBox plugin (issue #83).

## Version 2.4.2, 2018-07-10
### Changed
- Based on Raspbian Stretch Lite version of 2018-06-27 (issue #79).
- Updated to [version v1.11.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.11.0) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #81).

### Added
- Incron job added to support SD card partition resizing (issue #80).

## Version 2.4.1, 2018-06-12
### Changed
- Module iptables_raw for Ansible updated (issue #75).
- Updated to [version v1.10.4](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.10.4) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #76).

### Added
- Continuous integration with Travis CI added (first step).

### Fixed
- Default Wi-Fi AP channel changed to 11 (issue #74).
- Ansible Lint errors and warning fixed.

## Version 2.4.0, 2018-05-17
### Changed
- Change DNS to new Cloudflare ones, for privacy (issue #67).
- Custom Moodle course backup directory officially supported (issue #68).
- Updated to Moodle 3.5 (issue #69).
- Based on Raspbian Stretch Lite version of 2018-04-18 (issue #70).
- Module iptables_raw for Ansible updated (issue #72).
- Updated to [version v1.10.2](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.10.2) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox).

### Added
- Allow installation of unstable Moodle version (issue #73).

### Fixed
- Deprecated usage of tests as filters in Ansible 2.5.0 (issue #71).

## Version 2.3.0, 2018-03-21
### Changed
- Based on Raspbian Stretch Lite version of 2018-03-13 (issue #63).
- Updated to Moodle 3.4.2 (issue #64).
- Updated to [version v1.10](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.10) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox), enabling support of arbitrary chars in SSIDs.

### Added
- Support Raspberry Pi 3 B+ (issue #65).

## Version 2.2.0, 2018-03-02
### Changed
- Updated to Moodle 3.4.1 (issue #54).
- Changed frequency of Moodle cron to 1 minute (issue #58).
- Updated to [version v1.9](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.9) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox).

### Added
- Enabled startup/shutdown with hardware button, if present (issue #53).
- Now supports NTFS and exFAT formatted drives (issue #59 and #61).
- Moodle themes SCSS are now compiled after installation (issue #55).

### Fixed
- Cron spamming the logs (issue #60).

## Version 2.1.0, 2018-01-02
### Changed
- Based on Raspbian Stretch Lite version of 2017-11-29.
- Building is now done using Ansible (issue #48).

### Added
- Display info at SSH login (issue #51).

### Fixed
- Moodle installation directories no more hardcoded (issue #49).
- Top level domain name no more hardcoded (issue #52).

## Version 2.0.1, 2017-11-27
### Fixed
- Bug when trying to restore courses now really fixed (issue #45).

## Version 2.0, 2017-11-18
### Changed
- Updated to Moodle 3.4 (issue #44).
- Public DNS changed to more neutral ones (DNS.WATCH).

### Added
- MathJax library added to enable it to function when MoodleBox disconnected from Internet (issue #43).

### Fixed
- Bug when trying to restore courses is fixed (issue #45).

## Version 1.9.5, 2017-11-01
### Changed
- Network configuration updated, for better maintainability (issue #39).
- Enable separate log file for dnsmasq.
- Updated to [version v1.8](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.8) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox).

### Added
- File created on the MoodleBox to allow easy finding of version (issue #38).
- German version of summary texts added (see issue #36).

### Fixed
- Course backup size is no more limited by size of RAM temp partition (issue #18).
- Miscellaneous small fixes.

## Version 1.9.4, 2017-09-29
### Changed
- Extend DHCP range and reduce lease time to enable more IP addresses (issue #30).
- Revert previous fix for USBmount failure and fix it definitely (issue #21).
- Install Moodle in English, as default language (issue #35).
- Repository names changed (issue #33).
- Documentation file `MoodleBox.tex` removed from repo (issue #34).
- Updated to [version v1.7.1](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.7.1) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox).

### Added
- Install more common languages locales (issue #36).

### Fixed
- Set default locale to "en_GB" instead of "fr_FR" (issue #29).

## Version 1.9.3, 2017-09-11

### Changed
- Based on Raspbian Stretch Lite version of 2017-09-07.
- Updated to [version v1.7.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.7) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle (new Wi-Fi settings options available).
- Re-enable predictable network interface name, which is now disabled in Stretch image.

## Version 1.9.2, 2017-09-05
### Changed
- Issue #28 implemented: GUI to change Wi-Fi SSID and channel
- Updated to [version v1.6.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.6) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox), compatible with commit 46e5099.

### Added
- Change script for compatibility with [version v1.6.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.6) of the MoodleBox plugin for Moodle.

### Fixed

## Version 1.9.1, 2017-08-23
### Fixed
- Fix issue #25 (non-persistent setting of IP forwarding rules) using `iptables-persistent` package.

### Changed
- Moodle source is now installed in a new folder, preserving original nginx installation.

## Version 1.9, 2017-08-18
### Changed
- Debian Stretch!
- Based on Raspbian Stretch Lite version of 2017-08-16.
- Updated to Moodle 3.3.1+.
- Prompt color of moodlebox shell user changed to orange.

### Fixed
- Fixed automount of USB drives, replacing USBmount.
- Screen blanking is now turned off.

## Version 1.8.1, 2017-07-08
### Changed
- Based on Raspbian Jessie Lite version of 2017-07-05.
- Uses now new MariaDB root mecanism (with sudo, instead of DB password).
- Prompt of default shell user changed for better readability.

### Fixed
- Size of RAM partitions tweaked, as partial workaround for issue #18.
- Fixed value for `innodb_log_file_size`, which was set much too low (issue #19).

## Version 1.8, 2017-06-23
### Changed
- Based on Raspbian Jessie Lite version of 2017-06-21.
- Small documentation improvement.

## Version 1.7, 2017-06-08
### Changed
- Updated to Moodle 3.3+.
- New database user `moodlebox` for Moodle and phpMyAdmin database access.
- Cleanup enhanced at end of build.
- Documentation updated.

## Version 1.6.5, 2017-04-29
### Changed
- Release notes have now their own file.
- Some documentation improvements.

### Fixed
- Permissions changes to fix issue #16.
- Cosmetic fix in incron command.

## Version 1.6.4, 2017-04-11
### Changed
- Based on Raspbian Jessie Lite version of 2017-04-10.
- Updated to [version 1.4.4](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.4.4) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

## Version 1.6.3, 2017-03-25
### Changed
- Updated to Moodle 3.2.2.
- Description on front page now uses localisation.
- Better memory usage.
- InnoDB parameters tweaks for small performance improvements.

## Version 1.6.2, 2017-03-10
### Changed
- Uses now MariaDB 10.1.21.
- Better cleanup, for a smaller disk image.

### Fixed
- Other minor fixes.

## Version 1.6.1, 2017-03-04
### Changed
- Based on Raspbian Jessie Lite version of 2017-03-02.

### Fixed
- MariaDB default character encoding and collation updated (see issue [MDL-48228](https://tracker.moodle.org/browse/MDL-48228)).

## Version 1.6, 2017-02-27
### Changed
- Based on Raspbian Jessie Lite version of 2017-02-16.
- Uses now PHP7, for a 30% performance improvement :-).

## Version 1.5.1, 2017-02-11
### Fixed
- Prevent side effects after renaming the default user (symbolic link added).
- Updated package installation ordering.

## Version 1.5, 2017-01-31
### Changed
- Updated to Moodle 3.2.1.

### Added
- APCu cache module for PHP installed.

## Version 1.4.1, 2017-01-11
### Changed
- Based on Raspbian Jessie Lite version of 2017-01-11.
- Updated to Moodle 3.1.4.

## Version 1.4, 2016-12-21
### Added
- Added automatic filesystem resizing at first boot.

## Version 1.3.6, 2016-12-07
### Changed
- Updated to [version 1.4.3](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.4.3) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

### Fixed
- Maximum script execution time increased.
- Other minor fixes.

## Version 1.3.5, 2016-12-01
### Changed
- Based on Raspbian Jessie Lite version of 2016-11-25.
- Update of documentation.

### Fixed
- Other minor fixes.

## Version 1.3.4, 2016-11-04
### Changed
- Download Moodle with a shallow git clone, reducing dramatically the image size.
- Minor cleanup enhancements.

## Version 1.3.3, 2016-10-27
### Changed
- Based now on Raspbian Jessie Lite version of 2016-09-23.

### Fixed
- Fix to Wi-Fi configuration, enabling channel 12 and 13 if needed.
- Wi-Fi access point channel changed.
- Minor fixes to potential installation hiccups.

## Version 1.3.2, 2016-09-18
### Changed
- Updated to [version 1.4](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.4) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

## Version 1.3.1, 2016-09-10
### Changed
- Updated to [version 1.3](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.3) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle, fixing issue #4.

## Version 1.3, 2016-08-21
### Fixed
- Local DNS provided, enabling every device (with or without zeroconf) to access the MoodleBox via the FQDN `moodlebox.home`.

### Changed
- Moodle URL changed from `moodlebox.local` to `moodlebox.home`; the old URL redirects to the new one.

## Version 1.2.1, 2016-08-20
### Changed
- Changed database from MySQL to MariaDB, version 10.0.26.

## Version 1.2, 2016-08-11
### Changed
- Updated to [version 1.2](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.2) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

## Version 1.1.1, 2016-08-09
### Changed
- Documentation updated.
- Scripts to build the MoodleBox enhanced and updated.

## Version 1.1, 2016-08-06
### Added
- Added advertising of mDNS services (Avahi service file created).

### Changed
- Updated to [version 1.1](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.1) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This version adds display of free space on SD card of the MoodleBox.

## Version 1.0, 2016-07-11
### Added
- First publication of scripts to build the MoodleBox.

### Changed
- Updated to Moodle 3.1.1.
- Updated to [version 1.0](https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.0) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This version adds a time setting feature for the MoodleBox.

## Version 1.0b (beta), 2016-06-26
### Added
- Two temporary folders configured as RAM disks, for much better performance (see [this forum discussion on moodle.org](https://moodle.org/mod/forum/discuss.php?d=335066#p1350156)).

## Version 1.0a2 (alpha), 2016-06-19
### Changed
- Reorganisation of the project.
- Updated to version 1.0a2 of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle.

## Version 1.0a1 (alpha), 2016-06-16
### Added
- Installation of a preliminary version (1.0a1) of the [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) for Moodle. This plugin helps the administrator of the MoodleBox to monitor some hardware settings and allows restart and shutdown of the MoodleBox via GUI.

## Version 0.4 (pre-release), 2016-06-04
### Added
- The Moodle platform is configured to accept the clients from the Moodle [official mobile app](https://download.moodle.org/mobile/).

## Version 0.3 (pre-release), 2016-05-29
### Changed
- Updated to Moodle 3.1.
- Default account for SSH is now _moodlebox_ (instead of _pi_). Password is unchanged: _Moodlebox4$_.

## Version 0.2 (pre-release), 2016-05-19
### Added
- When a USB key is inserted in the MoodleBox, all the files on it are available for the admins and teachers of the Moodle server, via a _File system_ repository.
- Option to upload files on the MoodleBox via SFTP (username: _moodlebox_, password: _Moodlebox4$_); these files are available for the admins and teachers of the Moodle server, via a _File system_ repository.

## Version 0.1 (pre-release), 2016-04-13 (first version)
### Added
- The MoodleBox can be reached via SSH, username: _pi_, password: _Moodlebox4$_.
- The MoodleBox acts as a Wi-Fi access point. SSID: _MoodleBox_; password: _moodlebox_.;
- Moodle 3.0 installed on PHP 5.6.24, nginx 1.6.2 and MySQL 5.5.50 is accessible using the URL [http://moodlebox.local/](http://moodlebox.local/); standard configuration of Moodle with no customisation. An admin account for the Moodle, username: _admin_, password: _Moodlebox4$_.
- The maximal size of uploaded files in Moodle is set to 50Mb.
- The Moodle cron is launched every 3 minutes.
- Internet access: when the MoodleBox is connected via ethernet to a network connected to Internet, the MoodleBox acts as a router (IP forwarding) and the Wi-Fi clients have access to Internet.
- [PhpMyAdmin](http://moodlebox.local/phpmyadmin) is installed with an admin account; username: _root_, password: _Moodlebox4$_.
- RAM disk for `/var/cache/moodle`.
- No mail server, since the MoodleBox intended use is outside of any connection.
- Built on Raspbian Jessie Lite.
