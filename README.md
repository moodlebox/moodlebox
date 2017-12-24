# MoodleBox

[![GitHub release](https://img.shields.io/github/release/martignoni/moodlebox.svg)](https://github.com/martignoni/moodlebox/releases/latest)
[![GitHub Release Date](https://img.shields.io/github/release-date/martignoni/moodlebox.svg)](https://github.com/martignoni/moodlebox/releases/latest)
[![Github Downloads](https://img.shields.io/github/downloads/martignoni/moodlebox/total.svg)](https://github.com/martignoni/moodlebox/releases/latest)
[![GitHub last commit](https://img.shields.io/github/last-commit/martignoni/moodlebox.svg)](https://github.com/martignoni/moodlebox/commits/)

A project to build a Moodle server and Wi-Fi router on a Raspberry Pi 3.

## How to use a MoodleBox

Visit the [MoodleBox web site](https://moodlebox.net) for more information about the MoodleBox features or any question about the usage of a MoodleBox.

## Building the MoodleBox

To build a MoodleBox from scratch with this script, you need a Raspberri Pi 3 (Wi-Fi!) and follow these instructions.

1. Clone Rasbpian Stretch Lite on your microSD card.
1. Create a `ssh` file on the `boot` partition, e.g. using `touch ssh`.
1. Insert the microSD card into your Raspberry
1. Connect your Raspberry to your Ethernet network and boot it.
1. [Install Ansible](http://docs.ansible.com/intro_installation.html) on your computer.
1. [Clone this repository](https://github.com/martignoni/moodlebox.git) to your local drive.
1. Create a `keys` directory in the repository folder and copy your public key into it, under the name `id_rsa.pub`.
1. Get the IP address of your RaspberryPi and change it in the `hosts.yml` file. Do not change anything else, unless you know what you're doing. You're on your own.
1. Run `ansible-playbook moodlebox.yml` from the repository folder.
1. Wait 30–50 minutes, depending on your SD card and Internet bandwidth. You're done.

## Overriding defaults

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can change the MoodleBox main credentials and the timezone with something like:

    moodlebox_username: 'myusername'
    moodlebox_password: 'secret'
    moodlebox_timezone: 'Australia/Perth'

Any variable can be overridden in `config.yml`; see the file `default.config.yml` for a list of available variables.

## Availability

The code is available at [https://github.com/martignoni/moodlebox](https://github.com/martignoni/moodlebox).

A [prepared disk image](https://moodlebox.net/en/dl) of the latest released version is [available for downloading](htts://moodlebox.net/en/dl), cloning on your microSD card and using out of the box on your Raspberry Pi 3.

### Release notes

See [Release notes](https://github.com/martignoni/moodlebox/blob/master/CHANGELOG.md).

## Thanks

- To Daniel Méthot, for the [idea of a MoodleBox](https://moodle.org/mod/forum/discuss.php?d=278493)
- To Christian Westphal, for the [first POC](https://moodle.org/mod/forum/discuss.php?d=331170) of a MoodleBox
- To the [Raspberry Pi Foundation](https://www.raspberrypi.org/), for a splendid small computer
- To [Martin Dougiamas](https://en.wikipedia.org/wiki/Martin_Dougiamas), for giving us Moodle, and to the [Moodle community](https://moodle.org/)

## License

Copyright © 2016 onwards, Nicolas Martignoni <nicolas@martignoni.net>

- All the source code is licensed under GPL 3 or any later version.
- The documentation is licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
