# MoodleBox – Release notes

[![Github Downloads](https://img.shields.io/github/downloads/moodlebox/moodlebox/total.svg)](https://github.com/moodlebox/moodlebox/releases/)

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/) and follow principles of [keep a changelog](https://keepachangelog.com).

## Version 3.9.0, 2020-11-08
### Changed
- Update to Moodle 3.10 (issue #185).
- Update to Raspberry Pi OS version 2020-08-20 (issue #183).
- Update Mathjax library to version 2.7.9 (issue #188).
- Move upgrade tasks and files to specific branch (no issue number; commit 6ffe5f8; see issue #111).
- Remove build assets from repository (no issue number; commit d2b2916).
- Refactor roles (#181, commits 9ea8ac3, 2d92721, e3b564f).
- Remove useless screen blanking setting (no issue number; commit a84a802).
- Remove useless theme SCSS compilation task (no issue number; commit 51d7119).
- Do not remove whole Moodle source when uninstalling (no issue number; commit 6f29254).

### Added
- Add debug messages (no issue number; commits e804d6e, 04008c4, 1ead61a, b6865ae, 4338aa0).
- Add custom 'crt' file type in `config.php` for certificate (no issue number; commit bc67beb).

### Fixed
- Fix incron role idempotency (no issue number; commit 4fc16cd).
- Fix role for inexistent file (no issue number; commit a02af69).
- Fix timezone to correctly reflect MoodleBox origin country (no issue number; commit c8cbc2e).
- Silence a warning (no issue number; commit 8215a74).
- Increase timeout after cleanup (no issue number; commit b99b04c).
- Add two more files where to change pi name account (no issue number; commit c163f52).

## Version 3.8.0, 2020-07-25
### Changed
- Update Moodle to latest stable 3.9.x version (no issue number).
- Update Moodle to latest stable Adminer version (no issue number).
- Update [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) to [version v2.7.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.7.0) of (issue #179).
- Update [Nodogsplash](https://github.com/nodogsplash/nodogsplash) to version 5.0.0 (issues #177).

### Added
- Raspberry Pi 4B 8GB model is now fully supported (via issue #179).

### Fixed
- Fix definitely WiFi disabled issue on Raspberry Pi 3B (issue #176).
- Fix for php7.3-fpm SIGSEGV problem (issue #142).
- Fix Nodogsplash bad redirect (issue #162).

## Version 3.7.0, 2020-06-15
### Changed
- Update Moodle to version 3.9.0 (issue #173).
- Update to Raspberry Pi OS version 2020-05-27 (issue #172).
- Update [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) to [version v2.6.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.6.0) of (issue #174).
- Update [Nodogsplash](https://github.com/nodogsplash/nodogsplash) to version 4.5.1 (issues #169, #175).
- Update [MathJax](https://mathjax.org) to version 2.7.8 (issue #170).

### Added
- Add temporary workaround for WiFi disabling problem when swapping device (issue #176).

### Fixed
- Fix file ownership and permissions to enable edition by default user (issue #166).
- Update Ansible instructions (issue #167).
- Remove useless PHP module (no issue number).

## Version 3.6.0, 2020-02-12

### Changed
- Update Moodle to version 3.8.1+ (issue #161).
- Update to Raspbian version 2020-02-05 (issue #163).
- Update [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) to [version v2.5.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.5.0) of (issue #160).
- Update [Nodogsplash](https://github.com/nodogsplash/nodogsplash) to version 4.4.0 (issue #159).
- Update [MathJax](https://mathjax.org) to version 2.7.7 (issue #164).

### Added
- Add support for multiple subdomains (issue #158).
- Add temporary workaround for php7.3-fpm outages (issue #142).

## Version 3.5.1, 2019-11-30
### Fixed
- Fix partition auto-resize (issue #157).

## Version 3.5.0, 2019-11-18
### Changed
- Update Moodle to version 3.8.0 (issue #156).
- Update to Raspbian version 2019-09-26 (issue #149).
- Update [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) to [version v2.4.2](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.4.2) of (issue #152).
- Update [MathJax](https://mathjax.org) to version 2.7.6 (issue #154).
- Update [Nodogsplash](https://github.com/nodogsplash/nodogsplash) to version 4.3.2 (issue #153).

### Added
- Add support for HTTPS connexion (issue #27). This feature is not enabled by default; it must be manually enabled by a technically savvy administrator. See MoodleBox documentation.

### Fixed
- Fix author link (no issue number, commit b336068).

## Version 3.1.0, 2019-08-23
### Changed
- Updated to [version v2.4.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.4.0) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #146).
- Update [Nodogsplash](https://github.com/nodogsplash/nodogsplash) to v4.0.2 (issue #144), with temporary workaround for issue https://github.com/nodogsplash/nodogsplash/issues/419.

### Added
- Add `yamllint` to CI (no issue number)

### Fixed
- Fix `yaml` syntax (no issue number)

## Version 3.0.0, 2019-07-13
### Changed
- Updated to [version v2.2.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.2.0) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #136).
- Updated to Moodle 3.7.1 (issues #125 and #135).
- Updated to PHP7.3 (issue #94).
- Based on Raspbian Buster Lite version of 2019-07-10 (issue #139).
- Updated MoodleBox CSS preset (no issue number).
- Replace phpMyAdmin by Adminer (issue #132).

### Added
- Raspbian Buster support (issue #129).
- Raspberry Pi 4B (all RAM models) support (issue #136).

### Fixed
- IP forwarding on Buster (issue #129).
- Cleanup a database table (issue #138).
- Renaming home directory logic updated (no issue number).
- Broken image links in Nodogsplash (no issue number).
- IP filter syntax fixed to work with Ansible 2.8 and later (no issue number).
- Several warnings with Ansible 2.8 fixed (no issue number).

## Version 2.7.0, 2019-05-20
### Changed
- Updated to [version v2.0.0](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v2.0.0) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox) (issue #127).
- Updated to Moodle 3.6.4 (issue #128).
- Based on Raspbian Stretch Lite version of 2019-04-08 (issue #122).
- License is now AGPL (no issue number).

### Added
- Captive portal using [Nodogsplash](https://github.com/nodogsplash/nodogsplash) added (issue #120, PR #123). Inactive by default, needs to be started manually.
- Install default english Moodle locale: en_AU.UTF-8 to prevent false alerts with Moodle 3.7.0 and later (no issue number).

### Fixed
- Fix a bug introduced by an update to `hostapd` (issue #121).
- Fix plugin permissions on executable files (issue #126).
- Fix some warnings to Ansible playbooks (issue #119).
- Some fixes to preliminary version of upgrade script, still undocumented (issue #111). Use at your own risk.

## Version 2.6.2, 2019-02-03
### Changed
- Updated to Moodle 3.6.2 (issue #118).

### Added
- Preliminary version of upgrade script, undocumented (issue #111).

### Fixed
- Bug preventing correct completion of script fixed (issue #117). Thanks to @GXiangCo for the report.
- Several potential idempotence problems fixed (no issue number).

## Version 2.6.1, 2018-12-09
### Changed
- Updated to Moodle 3.6.1 (issue #113).
- Revert to PHP7.0 (issue #114).

## Version 2.6.0, 2018-12-03
### Changed
- Based on Raspbian Stretch Lite version of 2018-11-13 (issue #109).
- Uses now PHP7.1, with a slight performance gain (issue #100).
- Updated to Moodle 3.6 (issue #101).
- Updated to [version v1.12.2](
https://github.com/moodlebox/moodle-tool_moodlebox/releases/tag/v1.12.2) of [MoodleBox plugin](https://moodle.org/plugins/tool_moodlebox), enabling SSID hiding (issue #112).
- Username of default admin account changed to _moodlebox_ (issue #96).
- Updated to last version of `iptables_row` ansible module (issue #103).
- License change to AGPLv3 (issue #105).

### Added
- Ghostscript is installed by default, enabling PDF annotations (issue #108).

### Fixed
- Save some space by cloning a shallow clone of MoodleBox plugin (issue #104).
- Fix Ansible deprecation warning displayed when installing packages (issue #110).

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
