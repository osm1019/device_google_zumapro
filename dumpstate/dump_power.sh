#!/vendor/bin/sh
build_type="$(getprop ro.build.type)"

echo "\n------ Power Stats Times ------"
echo -n "Boot: " && /vendor/bin/uptime -s && echo -n "Now: " && date;

echo "\n------ ACPM stats ------"
for f in /sys/devices/platform/acpm_stats/*_stats ; do
  echo "\n\n$f"
  cat $f
done

echo "\n------ CPU PM stats ------"
cat "/sys/devices/system/cpu/cpupm/cpupm/time_in_state"

echo "\n------ GENPD summary ------"
cat "/d/pm_genpd/pm_genpd_summary"

echo "\n------ Power supply property battery ------"
cat "/sys/class/power_supply/battery/uevent"
echo "\n------ Power supply property dc ------"
cat "/sys/class/power_supply/dc/uevent"
echo "\n------ Power supply property gcpm ------"
cat "/sys/class/power_supply/gcpm/uevent"
echo "\n------ Power supply property gcpm_pps ------"
cat "/sys/class/power_supply/gcpm_pps/uevent"
echo "\n------ Power supply property main-charger ------"
cat "/sys/class/power_supply/main-charger/uevent"
echo "\n------ Power supply property dc-mains ------"
cat "/sys/class/power_supply/dc-mains/uevent"
echo "\n------ Power supply property tcpm ------"
cat "/sys/class/power_supply/tcpm-source-psy-8-0025/uevent"
echo "\n------ Power supply property usb ------"
cat "/sys/class/power_supply/usb/uevent"
echo "\n------ Power supply property wireless ------"
cat "/sys/class/power_supply/wireless/uevent"

if [ -d "/sys/class/power_supply/maxfg" ]
then
  echo "\n------ Power supply property maxfg ------"
  cat "/sys/class/power_supply/maxfg/uevent"
  echo "\n------ m5_state ------"
  cat "/sys/class/power_supply/maxfg/m5_model_state"
  echo "\n------ maxfg logbuffer------"
  cat "/dev/logbuffer_maxfg"
  echo "\n------ maxfg_monitor logbuffer------"
  cat "/dev/logbuffer_maxfg_monitor"
elif [ -d "/sys/class/power_supply/max77779fg" ]
then
  echo "\n------ Power supply property max77779fg ------"
  cat "/sys/class/power_supply/max77779fg/uevent"
  echo "\n------ m5_state ------"
  cat "/sys/class/power_supply/max77779fg/model_state"
  echo "\n------ max77779fg logbuffer------"
  cat "/dev/logbuffer_max77779fg"
  echo "\n------ max77779fg_monitor logbuffer ------"
  cat "/dev/logbuffer_max77779fg_monitor"
else
  echo "\n------ Power supply property maxfg_base ------"
  cat "/sys/class/power_supply/maxfg_base/uevent"
  echo "\n------ Power supply property maxfg_flip ------"
  cat "/sys/class/power_supply/maxfg_flip/uevent"
  echo "\n------ m5_state ------"
  cat "/sys/class/power_supply/maxfg_base/m5_model_state"
  echo "\n------ maxfg_base logbuffer------"
  cat "/dev/logbuffer_maxfg_base"
  echo "\n------ maxfg_flip logbuffer------"
  cat "/dev/logbuffer_maxfg_flip"
  echo "\n------ maxfg_base_monitor logbuffer------"
  cat "/dev/logbuffer_maxfg_base_monitor"
  echo "\n------ maxfg_flip_monitor logbuffer------"
  cat "/dev/logbuffer_maxfg_flip_monitor"
fi

if [ -e "/dev/maxfg_history" ]
then
  echo "\n------ Maxim FG History ------"
  cat "/dev/maxfg_history"
fi

if [ -d "/sys/class/power_supply/dock" ]
then
  echo "\n------ Power supply property dock ------"
  cat "/sys/class/power_supply/dock/uevent"
fi

if [ -e "/dev/logbuffer_tcpm" ]
then
  echo "\n------ Logbuffer TCPM ------"
  cat "/dev/logbuffer_tcpm"
  if [ -d "/sys/kernel/debug/tcpm" ]
  then
    echo "\n------ TCPM logs ------"
    cat /sys/kernel/debug/tcpm/*
  else
    echo "\n------ TCPM logs ------"
    cat /sys/kernel/debug/usb/tcpm*
  fi
fi

echo "\n------ TCPC ------"
for f in /sys/devices/platform/10d60000.hsi2c/i2c-*/i2c-max77759tcpc
do
  echo "registers:"
  cat $f/registers
  echo "frs:"
  cat $f/frs
  echo "auto_discharge:"
  cat $f/auto_discharge
  echo "bc12_enabled:"
  cat $f/bc12_enabled
  echo "cc_toggle_enable:"
  cat $f/cc_toggle_enable
  echo "contaminant_detection:"
  cat $f/contaminant_detection
  echo "contaminant_detection_status:"
  cat $f/contaminant_detection_status
done

echo "\n------ PD Engine logbuffer------"
cat "/dev/logbuffer_usbpd"
echo "\n------ PPS-google_cpm logbuffer------"
cat "/dev/logbuffer_cpm"
echo "\n------ PPS-dc logbuffer------"
if [ -d "/dev/logbuffer_pca9468" ]
then
  cat "/dev/logbuffer_pca9468"
else
  cat "/dev/logbuffer_ln8411"
fi

echo "\n------ Battery Health ------"
cat "/sys/class/power_supply/battery/health_index_stats"
echo "\n------ BMS logbuffer------"
cat "/dev/logbuffer_ssoc"
echo "\n------ TTF logbuffer-----"
cat "/dev/logbuffer_ttf"
echo "\n------ TTF details ------"
cat "/sys/class/power_supply/battery/ttf_details"
echo "\n------ TTF stats ------"
cat "/sys/class/power_supply/battery/ttf_stats"
echo "\n------ aacr_state ------"
cat "/sys/class/power_supply/battery/aacr_state"
echo "\n------ pairing_state ------"
cat "/sys/class/power_supply/battery/pairing_state"
if [ -d "/dev/logbuffer_maxq" ]
then
  echo "\n------ maxq logbuffer------"
  cat "/dev/logbuffer_maxq"
fi
echo "\n------ TEMP/DOCK-DEFEND ------"
cat "/dev/logbuffer_bd"

echo "\n------ TRICKLE-DEFEND Config ------"
cd /sys/devices/platform/google,battery/power_supply/battery/
for f in `ls bd_*`
do
  echo $f: `cat $f`
done

echo "\n------ DWELL-DEFEND Config ------"
cd /sys/devices/platform/google,charger/
for f in `ls charge_s*`
do
  echo "$f: `cat $f`"
done

echo "\n------ TEMP-DEFEND Config ------"
cd /sys/devices/platform/google,charger/
for f in `ls bd_*`
do
  echo "$f: `cat $f`"
done

if [ $build_type = "userdebug" ]
then
  echo "\n------ DC_registers dump ------"
  cat "/sys/class/power_supply/dc-mains/device/registers_dump"
  if [ -d "/d/max77759_chg" ]
  then
    echo "\n------ max77759_chg registers dump ------"
    cat "/d/max77759_chg/registers"
    echo "\n------ max77729_pmic registers dump ------"
    cat "/d/max77729_pmic/registers"
  else
    echo "\n------ max77779_chg registers dump ------"
    cat "/d/max77779_chg/registers"
    echo "\n------ max77779_pmic registers dump ------"
    cat "/d/max77779_pmic/registers"
  fi
  echo "\n------ Charging table dump ------"
  cat "/d/google_battery/chg_raw_profile"

  if [ -d "/d/maxfg" ]
  then
    for f in /d/maxfg*
    do
      regs=`cat $f/fg_model`
      echo "\n------ $f/fg_model ------:"
      echo "$regs"
      regs=`cat $f/algo_ver`
      echo "\n------ $f/algo_ver ------:"
      echo "$regs"
      regs=`cat $f/model_ok`
      echo "\n------ $f/model_ok ------:"
      echo "$regs"
      regs=`cat $f/registers`
      echo "\n------ $f/registers ------:"
      echo "$regs"
      regs=`cat $f/nv_registers`
      echo "\n------ $f/nv_registers ------:"
      echo "$regs"
    done
  else
    for f in /d/max77779fg*
    do
      regs=`cat $f/fg_model`
      echo "\n------ $f/fg_model ------:"
      echo "$regs"
      regs=`cat $f/model_ok`
      echo "\n------ $f/model_ok ------:"
      echo "$regs"
      regs=`cat $f/registers`
      echo "\n------ $f/registers ------:"
      echo "$regs"
      regs=`cat $f/debug_registers`
      echo "\n------ $f/debug_registers ------:"
      echo "$regs"
    done
  fi
fi

echo "\n------ Battery EEPROM ------"
if [ -e "/sys/devices/platform/10c90000.hsi2c/i2c-7/7-0050/eeprom" ]
then
  xxd /sys/devices/platform/10c90000.hsi2c/i2c-7/7-0050/eeprom
fi

if [ -e "/sys/devices/platform/10c90000.hsi2c/i2c-6/6-0050/eeprom" ]
then
  xxd /sys/devices/platform/10c90000.hsi2c/i2c-6/6-0050/eeprom
fi

if [ -e "/sys/devices/platform/10ca0000.hsi2c/i2c-6/6-0050/eeprom" ]
then
  xxd /sys/devices/platform/10ca0000.hsi2c/i2c-6/6-0050/eeprom
fi

echo "\n------ Charger Stats ------"
cat "/sys/class/power_supply/battery/charge_details"
if [ $build_type = "userdebug" ]
then
  echo "\n------ Google Charger ------"
  cd /sys/kernel/debug/google_charger/
  for f in `ls pps_*`
  do
    echo "$f: `cat $f`"
  done
  echo "\n------ Google Battery ------"
  cd /sys/kernel/debug/google_battery/
  for f in `ls ssoc_*`
  do
    echo "$f: `cat $f`"
  done
fi

echo "\n------ WLC logs logbuffer------"
cat "/dev/logbuffer_wireless"
echo "\n------ WLC VER ------"
cat "/sys/class/power_supply/wireless/device/version"
echo "\n------ WLC STATUS ------"
cat "/sys/class/power_supply/wireless/device/status"
echo "\n------ WLC FW Version ------"
cat "/sys/class/power_supply/wireless/device/fw_rev"
echo "\n------ RTX logbuffer------"
cat "/dev/logbuffer_rtx"

if [ $build_type = "userdebug" ]
then
  echo "\n------ gvotables ------"
  cat /sys/kernel/debug/gvotables/*/status
fi

echo "\n------ Lastmeal ------"
cat "/data/vendor/mitigation/lastmeal.txt"
echo "\n------ Thismeal ------"
cat "/data/vendor/mitigation/thismeal.txt"
echo "\n------ Mitigation Stats ------"
echo "Source\t\tCount\tSOC\tTime\tVoltage"
for f in `ls /sys/devices/virtual/pmic/mitigation/last_triggered_count/*`
do
  count=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/last_triggered_count\//}
  b=${f/last_triggered_count/last_triggered_capacity}
  c=${f/last_triggered_count/last_triggered_timestamp/}
  d=${f/last_triggered_count/last_triggered_voltage/}
  cnt=`cat $f`
  cap=`cat ${b/count/cap}`
  ti=`cat ${c/count/time}`
  volt=`cat ${d/count/volt}`
  echo "${a/_count/} \t$cnt\t$cap\t$ti\t$volt"
done

echo "\n------ Clock Divider Ratio ------"
echo \"Source\t\tRatio\"
for f in `ls /sys/devices/virtual/pmic/mitigation/clock_ratio/*`
do ratio=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/clock_ratio\//}
  echo "${a/_ratio/} \t$ratio"
done

echo "\n------ Clock Stats ------"
echo "Source\t\tStats"
for f in `ls /sys/devices/virtual/pmic/mitigation/clock_stats/*`
do
  stats=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/clock_stats\//};
  echo "${a/_stats/} \t$stats"
done

echo "\n------ Triggered Level ------"
echo "Source\t\tLevel"
for f in `ls /sys/devices/virtual/pmic/mitigation/triggered_lvl/*`
do
  lvl=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/triggered_lvl\//}
  echo "${a/_lvl/} \t$lvl"
done

echo "\n------ Instruction ------"
for f in `ls /sys/devices/virtual/pmic/mitigation/instruction/*`
do
  val=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/instruction\//}
  echo "$a=$val"
done

echo "\n------ IRQ Duration Counts ------"
echo "Source\t\t\t\tlt_5ms_cnt\tbt_5ms_to_10ms_cnt\tgt_10ms_cnt\tCode\tCurrent Threshold (uA)\tCurrent Reading (uA)"

lt=`cat /sys/devices/virtual/pmic/mitigation/irq_dur_cnt/less_than_5ms_count`
bt=`cat /sys/devices/virtual/pmic/mitigation/irq_dur_cnt/between_5ms_to_10ms_count`
gt=`cat /sys/devices/virtual/pmic/mitigation/irq_dur_cnt/greater_than_10ms_count`
lpf_cur_m=`cat /sys/devices/platform/acpm_mfd_bus@15500000/i2c-0/0-001f/s2mpg14-meter/s2mpg14-odpm/iio:device0/lpf_current`
lpf_cur_s=`cat /sys/devices/platform/acpm_mfd_bus@15510000/i2c-1/1-002f/s2mpg15-meter/s2mpg15-odpm/iio:device1/lpf_current`

lpf_cur_main=(${lpf_cur_m/\\n/;})
lpf_cur_sub=(${lpf_cur_s/\\n/;})

IFS_PRE=$IFS
IFS=$'\n'
lt_a=($lt)
bt_a=($bt)
gt_a=($gt)
IFS=$IFS_PRE


for f in `ls /sys/devices/virtual/pmic/mitigation/main_pwrwarn/*`
do
  count=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/main_pwrwarn\//}
  s=${a/main_pwrwarn_threshold/}
  arr=(${count//=/ })
  code=${arr[0]}
  threshold=${arr[1]}
  main_array[$s]="$code\t$threshold"
done

i=1
main_current=()
for f in "${main_array[@]}"
do
  idx=$i
  idx2=$idx+1
  main_current+=(${lpf_cur_main[$idx2]})
  i=$i+2
done

for f in `ls /sys/devices/virtual/pmic/mitigation/sub_pwrwarn/*`
do
  count=`cat $f`
  a=${f/\/sys\/devices\/virtual\/pmic\/mitigation\/sub_pwrwarn\//}
  s=${a/sub_pwrwarn_threshold/}
  arr=(${count//=/ })
  code=${arr[0]};
  threshold=${arr[1]};
  sub_array[$s]="$code\t$threshold"
done
i=1
sub_current=()
for f in "${sub_array[@]}"
do
  idx=$i
  idx2=$idx+1
  sub_current+=(${lpf_cur_sub[$idx2]})
  i=$i+2
done

rows=${#lt_a[@]}
for i in `seq 0 $rows`
do
  n="${lt_a[i]%:*}"
  l="${lt_a[i]#*": "}"
  b="${bt_a[i]#*": "}"
  g="${gt_a[i]#*": "}"
  if [ $i -lt 9 ]
  then
    echo "$n     \t\t$l\t\t$b\t\t\t$g"
  elif [ $i -ge 9 ] && [ $i -lt 21 ]
  then
    j=$i-9
    thresh="${main_array[j]}"
    current="${main_current[j]}"
    echo "$n     \t$l\t\t$b\t\t\t$g\t\t$thresh      \t\t$current"
  else
    j=$i-21
    thresh="${sub_array[j]}"
    current="${sub_current[j]}"
    echo "$n     \t$l\t\t$b\t\t\t$g\t\t$thresh      \t\t$current"
  fi
done
