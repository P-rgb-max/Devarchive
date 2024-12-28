setfont -d

echo WARNING: All your responses to the script should be written lowercase.

echo Provide login and password for your Wifi \(login, then, when prompted, password\) or connect Ethernet cable \(skip with Enter\) or just connect Internet yourself \(press CTRL-C, use iwctl\; if already just, skip with Enter\) \>
read _none
if [[ $_none -ne '' ]];then
iwctl << _eof
station wlan0 connect $_none
_eof
echo Connected!
fi

echo The next table will be a list of all disks connected to your device. Choose one that is the disk you want to install the Devarchive to.\nWARNING: Only specify name of the drive \(eg. sda or mmcblk1\), without specifying neither partition nor the /dev/ prefix. \>
lsblk
read disk
if [[ $disk -eq mmc* ]];then
disk_add=p
else
disk_add=''
fi
disk=/dev/$disk

echo WARNING: The next operation will erase \& format your disk you chose to install Devarchive to. Type \"yes, format\" if you want to continue
read _none
if [[ $_none -ne 'yes, format' ]];then
echo Cancelling...;exit
fi

echo Starting partitioning...
fdisk $disk << _eof
d
1
d
2
d
3
d
4
n


+100m
n
n


+4g
n



t
1
1
t
2
19
t
3
23
w
_eof

echo Partitioning finished!

_none=${disk}{$disk_add}

echo Formatting partitions...
mkfs.fat -F 32 ${_none}1
mkswap ${_none}2
mkfs.ext4 ${_none}3
echo Finished formatting!

echo Mounting partitions...
mount ${_none}3 /mnt
mount --mkdir ${_none}1 /mnt/boot/efi
swapoff ${_none}2
echo Mounted the partitions

reflector\>/dev/null
pacstrap /mnt base linux linux-firmware networkmanager nano grub efibootmbr sof-fireware \
    base-devel
echo Installed the base OS

genfstab /mnt\>/mnt/etc/fstab
echo Created the fstab file at /etc folder on the target system

key=$(echo $disk|base64)
echo After this step, follow the \"Chrooted system\" \(CLI mode\) step in the README.md guide
echo Also, provide this key as parameter the cli_chroot.sh: \"${key}\" \(without quotes)
arch-chroot /mnt
