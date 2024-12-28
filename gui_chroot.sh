setfont -d

echo WARNING: All your responses to the script should be written lowercase.
echo You are almost done! Now, installing developer tools.

if [[ $# -lt 2 ]];then
echo Usage: `basename $0` <key>
echo    key - a key provided in the end of the \`cli.sh\` installer script.
exit 1
fi
disk=$(echo $1|base64 -d)

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
read user
useradd -mGwheel -s/bin/bash $user
echo Right now, enter a password for your user once asked
passwd $user

echo Do you want your user \"$user\" to run \`sudo\` command without asking for password? \[Y\]es, \[N\]o \>
read _none
if [[ $_none -eq y ]];then
echo %wheel ALL=(ALL) NOPASSWD: ALL>>/etc/sudoers
else
echo %wheel ALL=(ALL) ALL>>/etc/sudoers
fi

# ! Feel free to edit this row. This will change which packages will be installed to the final system
echo This step will install basic developer tools and graphical environment. Edit row 53 of this script to change minimal packages, and variables \`deskenv\` and \`dispman\` \(rows 51 \& 52\) to change desktop environment and display manager.
deskenv=lxde
dispman=lightdm # If this is `lightdm`, follow the "LightDM setup" (Miscellaneous) in the README.md
pacman -S xterm zsh vim emacs code --noconfirm
pacman -S $deskenv $dispman --noconfirm

systemctl enable NetworkManager
echo NetworkManager enabled. To connect WiFi, use \`nmtui\` once booted into the new system.

systemctl enable $dispman
echo Your preferred display manager enabled. It will start once you boot into the system.

echo Installing GRUB bootloader. Don\'t mind if there will be an error, it happens sometimes, the second time its solved.
grub-install $disk
grub-install $disk
echo GRUB should now be successfully installed. Configurating now...
grub-mkconfig -o /boot/grub/grub.cfg
echo

if [[ $dispman -eq lightdm ]];then
key=$(echo $user|base64)
echo Provide this key to the script \`lightdm.sh\` if you want to setup autologin for your user: $key
fi

echo Now, once in the live environment again, follow the \"Cleaning up\" \(CLI mode\) step in the README.md guide
exit
