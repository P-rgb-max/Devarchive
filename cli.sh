setfont -d

echo 'WARNING: All your responses to the script should be written lowercase.'

echo 'Provide login and password for your Wifi (login, then, when prompted, password) or connect Ethernet cable (skip with Enter) or just connect Internet yourself (press CTRL-C, use iwctl; if already just, skip with Enter)'
read _none
if [[ $_none -ne '' ]];then
iwctl << _eof
station wlan0 connect $_none
_eof
echo 'Connected!'
fi

echo 'The next table will be a list of all disks connected to your device. Choose one that is the disk you want to install the Devarchive to.\nWARNING: Only specify name of the drive (eg. sda or mmcblk1), without specifying neither partition nor /dev folder. >'
lsblk
read disk

if [[ $disk -e mmc* ]];then
disk_add=p
else
disk_add=''
fi

echo 'WARNING: The next operation will erase & format your disk you chose to install Devarchive to. Type "yes, format" if you want to continue'
read _none
if [[ $_none -ne 'yes, format' ]];then
echo 'Cancelling...';exit
fi

echo 'Starting partitioning...'
fdisk /dev/$disk << _eof
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

echo 'Partitioning finished!'

echo 'Formatting partitions...'
mkfs.fat -F 32 /dev/${disk}${disk_add}1
mkswap /dev/${disk}${disk_add}2
mkfs.ext4 /dev/${disk}${disk_add}3
echo 'Finished formatting!'

echo 'Mounting partitions...'
mount /dev/${disk}${disk_add}3 /mnt
mount --mkdir /dev/${disk}${disk_add}1 /mnt/boot/efi
swapoff /dev/${disk}${disk_add}2
echo 'Mounted the partitions'

reflector>/dev/null
pacstrap /mnt base linux linux-firmware networkmanager nano grub efibootmbr sof-fireware \
    base-devel
echo 'Installed the base OS'

genfstab /mnt>/mnt/etc/fstab
echo 'Created the fstab file at /etc folder on the target system'

echo 'After this step, follow the "Chrooted system" (CLI mode) step in the README.md guide'
arch-chroot /mnt
