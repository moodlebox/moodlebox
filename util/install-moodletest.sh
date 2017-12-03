#!/bin/bash
# Copyright © 2015 onwards, Nicolas Martignoni <nicolas@martignoni.net>
#
# This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
# http://creativecommons.org/licenses/by-nc-sa/4.0/
#
# This script installs a Moodle platform with following users
#   * 1 admin : admin
#   * 3 teachers : teacher1, teacher2, teacher3
#   * 5 students : student1, student2, student3, student4, student5
# and following courses and enrolments
#   * course1
#       teacher1, teacher2
#       student1, student2, student4, student5
#   * course2
#       teacher2, teacher3
#       student2 ,student3, student4, student5
#   * course3
#       teacher1, teacher3
#       student1, student2, student3, student5
#
# This script uses moosh <http://moosh-online.com>, a command line tool by
# Tomasz Muras that will allow you to perform most common Moodle tasks.
#

# This script MUST be run as root
[[ $EUID -ne 0 ]] && { echo "This script must be run as root"; exit 1; }

## set useful vars
dummypassword="123456"
moodleurl="http://moodlebox.local"
moodlename="MoodleBox"
moodleshortname="MoodleBox"
databasename="moodle"
databaseprefix="mdl_"
databaseuser="root"
databasepassword="Moodlebox4$"
emaildomain="moodlebox.invalid"
city="Fribourg"
country="CH"

## set paths
## path of directory where this very file is stored
# selfpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## path of root and data directories of Moodle installation
moodlerootpath="/var/www/moodle"
moodledatapath="/var/www/moodledata"

## path of moosh folder
mooshpath="/home/moodlebox/moosh"
## script and options
mooshscript="$mooshpath/moosh.php -n -p $moodlerootpath"
#
# ## First we launch the install procedure of Moodle
#
# ## Backup existing config.php
# mv "$moodlerootpath/config.php" "$moodlerootpath/config.php.backup"
# ## Create config.php and database tables (when config.php doesn't exist yet)
# /usr/bin/php "$moodlerootpath/admin/cli/install.php" \
#   --lang=fr \
#   --wwwroot="$moodleurl" \
#   --dataroot="$moodledatapath" \
#   --dbname="$databasename" \
#   --prefix="$databaseprefix" \
#   --dbuser="$databaseuser" \
#   --dbpass="$databasepassword" \
#   --fullname="$moodlename" \
#   --shortname="$moodleshortname" \
#   --adminuser=admin \
#   --adminpass="$dummypassword" \
#   --non-interactive \
#   --agree-license
#
# ## Create database tables (with existing config.php)
# /usr/bin/php "$moodlerootpath/admin/cli/install_database.php" \
#   --lang=fr \
#   --adminpass=123456 \
#   --agree-license

# ## Fix ownership of Moodle files
# chown -R www-data:www-data "$moodlerootpath"

## Configure Moodle site

# change admin's user email address
$mooshscript user-mod --email admin@"$emaildomain"
# allow cron via browser GUI and set password
$mooshscript config-set cronclionly 0
$mooshscript config-set cronremotepassword "$dummypassword"
# set sitewide default number of course sections (three)
$mooshscript config-set numsections 3 moodlecourse
# set sitewide default course format (topics)
$mooshscript config-set format topics moodlecourse
# set sitewide default number news items to display in courses (0)
$mooshscript config-set newsitems 0 moodlecourse
# set first day of week as monday
$mooshscript config-set calendar_startwday 1
# enable conditional availability
$mooshscript config-set enableavailability 1
# enable completion of activities
$mooshscript config-set enablecompletion 1

## Create users and courses

# create 3 users to use as (edititng) teachers
$mooshscript user-create --password "$dummypassword" --email teacher1@"$emaildomain" --city "$city" --country "$country" --firstname "Tina" --lastname "Teacher" teacher1
$mooshscript user-create --password "$dummypassword" --email teacher2@"$emaildomain" --city "$city" --country "$country" --firstname "Terry" --lastname "Teacher" teacher2
$mooshscript user-create --password "$dummypassword" --email teacher3@"$emaildomain" --city "$city" --country "$country" --firstname "Teresa" --lastname "Teacher" teacher3
# create 5 users to use as students
$mooshscript user-create --password "$dummypassword" --email student1@"$emaildomain" --city "$city" --country "$country" --firstname "Suzy" --lastname "Student" student1
$mooshscript user-create --password "$dummypassword" --email student2@"$emaildomain" --city "$city" --country "$country" --firstname "Steve" --lastname "Student" student2
$mooshscript user-create --password "$dummypassword" --email student3@"$emaildomain" --city "$city" --country "$country" --firstname "Sammy" --lastname "Student" student3
$mooshscript user-create --password "$dummypassword" --email student4@"$emaildomain" --city "$city" --country "$country" --firstname "Sofia" --lastname "Student" student4
$mooshscript user-create --password "$dummypassword" --email student5@"$emaildomain" --city "$city" --country "$country" --firstname "Sean" --lastname "Student" student5
# create 3 courses
$mooshscript course-create --fullname "Course 3" --description "Cours de test 3" --idnumber "13" course3
$mooshscript course-create --fullname "Course 2" --description "Cours de test 2" --idnumber "12" course2
$mooshscript course-create --fullname "Course 1" --description "Cours de test 1" --idnumber "11" course1
# enrol users into course1
$mooshscript course-enrol -r editingteacher 2 teacher1 teacher2
$mooshscript course-enrol -r student 2 student1 student2 student4 student5
# enrol users into course2
$mooshscript course-enrol -r editingteacher 3 teacher2 teacher3
$mooshscript course-enrol -r student 3 student2 student3 student4 student5
# enrol users into course3
$mooshscript course-enrol -r editingteacher 4 teacher1 teacher3
$mooshscript course-enrol -r student 4 student1 student2 student3 student5

# the end
