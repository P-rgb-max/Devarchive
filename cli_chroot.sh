setfont -d

echo WARNING: All your responses to the script should be written lowercase.
echo You are almost done! Now, installing developer tools.

if [[ $# -lt 2 ]];then
echo Usage: `basename $0` <key>
echo    key - a key provided in the end of the \`cli.sh\` installer script.
exit 1
fi
disk=$1

echo Choose your region. Type in Region/City, eg. Asia/Dubai. \>
read _none
ln -sf /usr/share/zoneinfo/${_none} /etc/localtime
hwclock --systohc
echo Date is set up.

echo en_US.UTF-8 UTF-8>/etc/locale.gen
locale-gen
echo Locale generation complete.

echo LANG=en_US.UTF-8>/etc/locale.conf
echo KEYMAP=us>/etc/vconsole.conf
echo Locale binded and keymap set.

echo Choose a hostname for your new Devarchive \>
read _none
echo ${_none}>/etc/hostname

echo In the next step, we will setup root password and create a new user.
echo Right now, enter new root password when prompted \(it will become root password of your new system\).
passwd

echo Now, choose a name for your user. \>
read _none
useradd -mGwheel -s/bin/bash $_none
echo Right now, enter a password for your user once asked
passwd $_none

echo Do you want your user \"$_none\" to run \`sudo\` command without asking for password? \[Y\]es, \[N\]o \>
read _none
if [[ $_none -eq y ]];then
echo %wheel ALL=(ALL) NOPASSWD: ALL>>/etc/sudoers
else
echo %wheel ALL=(ALL) ALL>>/etc/sudoers
fi

# ! Feel free to edit this row. This will change which packages will be installed to the final system
echo This step will install basic developer tools. Feel free to edit row 44 in this script to change the list of installed packages.
pacman -S emacs vim zsh

systemctl enable NetworkManager
echo NetworkManager enabled. To connect WiFi, use \`nmtui\` once booted into the new system.

echo Installing GRUB bootloader. Don\'t mind if there will be an error, it happens sometimes, the second time its solved.
grub-install $disk
grub-install $disk
echo GRUB should now be successfully installed. Configurating now...
grub-mkconfig -o /boot/grub/grub.cfg
echo

echo Now, once in the live environment again, follow the \"Cleaning up\" \(CLI mode\) step in the README.md guide
exit
