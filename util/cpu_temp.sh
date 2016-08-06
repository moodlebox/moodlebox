#! /bin/bash
/bin/date +%T | awk '{print "time="$1}'
awk '{print "gov="$1}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
awk '{print "freq="$1/1000"Mhz"}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
awk '{print "temp="$1/1000"°C"}' /sys/class/thermal/thermal_zone0/temp
df | awk '$NF == "/" { print "sdcard avail="sprintf("%.2f", $4/(1024*1024))"GB ("sprintf("%.2f", 100*$4/$2)"%)" }'
#/opt/vc/bin/vcgencmd measure_clock arm
#/opt/vc/bin/vcgencmd measure_temp
/opt/vc/bin/vcgencmd measure_volts core
