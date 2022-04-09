# MoodleBox

[![GitHub release](https://img.shields.io/github/release/moodlebox/moodlebox.svg)](https://github.com/moodlebox/moodlebox/releases/latest)
[![GitHub Release Date](https://img.shields.io/github/release-date/moodlebox/moodlebox.svg)](https://github.com/moodlebox/moodlebox/releases/latest)
[![Github Downloads](https://img.shields.io/github/downloads/moodlebox/moodlebox/total.svg)](https://github.com/moodlebox/moodlebox/releases/)
[![GitHub last commit](https://img.shields.io/github/last-commit/moodlebox/moodlebox.svg)](https://github.com/moodlebox/moodlebox/commits/)
[![CI](https://github.com/moodlebox/moodlebox/workflows/CI/badge.svg)](https://github.com/moodlebox/moodlebox/actions?query=workflow%3ACI)
[![Donate PayPal](https://img.shields.io/badge/donate-PayPal-orange.svg)](https://www.paypal.me/moodlebox/50)

A Moodle server and Wi-Fi router on Raspberry Pi.

## The MoodleBox Documentation

Visit the [MoodleBox web site][website] for more information about the MoodleBox features or any question about the usage of a MoodleBox.

If you just want to use a MoodleBox, a [prepared disk image][download] of the latest released version is [available for downloading][download] and using out of the box on your Raspberry Pi 3A, 3B, 3B+ or 4B. Follow the instructions on the [MoodleBox web site][website].

### Asking Support Questions

We have an active [discussion forum][forum] where users and developers can ask questions. Please don't use the GitHub issue tracker to ask questions.

## Building the MoodleBox disk image from scratch

> If you just want to use a MoodleBox, __you don't need__ to build the MoodleBox disk image yourself. Just [download the MoodleBox image][download] and follow the instructions on the [MoodleBox web site][website].

To build a MoodleBox from scratch with this script, you need a Raspberry Pi 3A, 3B, 3B+ or 4B.

1. Clone [Raspberry Pi OS (64-bit) Lite image](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) on your microSD card.
1. Create a `ssh.txt` file on the `boot` partition with any content.
1. Create a `userconf.txt` file on the `boot` partition, and add the following line to it:
   `moodlebox:$6$rmLgDblolU16oLmc$i7QzARV8o84tCDQA/Kq1xU3eYwPWlocqVmpFTcSWqAqiWJpFyTLd.g9W5ktDDh16rq5lwYG9wpHY224m5nHLk0`
1. Insert the microSD card into your Raspberry Pi.
1. Connect your Raspberry Pi to your Ethernet network and boot it.
1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) on your computer. On macOS, use e.g. `brew install ansible`.
1. [Install `sshpass`](https://gist.github.com/arunoda/7790979) to enable passing SSH password to the Raspberry Pi. On macOS, use e.g. `brew tap esolitos/ipa; brew install sshpass`.
1. [Clone this repository][git] to your local drive.
1. Create a `keys` directory in the repository folder and copy your public key into it, under the name `id_rsa.pub`.
1. Get the IP address of your Raspberry Pi and change it in the `hosts.yml` file. Do not change anything else, unless you know what you're doing. You're on your own.
1. Run `ansible-playbook moodlebox.yml` from the repository folder.
1. Wait 15–50 minutes, depending on your Raspberry Pi model, SD card speed and Internet bandwidth. You're done.

### Overriding defaults

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can change the MoodleBox main credentials and the timezone with something like:

    moodlebox_username: 'myusername'
    moodlebox_password: 'secret'
    moodlebox_timezone: 'Australia/Perth'

Any variable can be overridden in `config.yml`; see the file `default.config.yml` for a list of available variables.

## Availability

The code is available at [https://github.com/moodlebox/moodlebox][git].

### Release notes

See [Release notes](https://github.com/moodlebox/moodlebox/blob/master/CHANGELOG.md).

## Sponsor

MoodleBox is sponsored by [E-learning Touch'](https://www.elearningtouch.com/) Moodle Partner.

![E-learning Touch'](https://www.elearningtouch.com/wp-content/uploads/2018/09/logo_elt_2018.jpg)

## Thanks

- To Daniel Méthot, for the [idea of a MoodleBox](https://moodle.org/mod/forum/discuss.php?d=278493)
- To Christian Westphal, for the [first POC](https://moodle.org/mod/forum/discuss.php?d=331170) of a MoodleBox
- To the [Raspberry Pi Foundation](https://www.raspberrypi.org/), for a splendid small computer
- To [Martin Dougiamas](https://en.wikipedia.org/wiki/Martin_Dougiamas), for giving us Moodle, and to the [Moodle community](https://moodle.org/)

## License

Copyright © 2016 onwards, Nicolas Martignoni nicolas@martignoni.net.

All contributions to this repository are licensed under AGPLv3 or any later version.

MoodleBox doesn't require a CLA (Contributor License Agreement). The copyright belongs to all the individual contributors. Therefore we recommend that every contributor adds following line to the header of a file, if they
changed it substantially:

```
@copyright Copyright © <year>, <your name> (<your email address>)
```

  [website]: https://moodlebox.net
  [download]: https://moodlebox.net/download
  [forum]: https://discuss.moodlebox.net/
  [git]: https://github.com/moodlebox/moodlebox
