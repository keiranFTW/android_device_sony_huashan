#!/system/bin/sh
#
# Sony SP wifi load
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

    calparm=`ls /sys/module/wcnsscore/parameters/has_calibrated_data`
        if [ -e $calparm ] && [ ! -e /data/misc/wifi/WCN_FACTORY ]; then
            echo 1 > $calparm
        fi
    # There is a device file.  Write to the file
    # so that the driver knows userspace is
    # available for firmware download requests
    echo 1 > /dev/wcnss_wlan

    # Plumb down the device serial number
        echo $serialno > /sys/devices/platform/wcnss_wlan.0/serial_number

    setprop wlan.driver.ath 0 

    setprop wlan.driver.config /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini

# Load cfg80211 kernel module
insmod /system/lib/modules/cfg80211.ko
