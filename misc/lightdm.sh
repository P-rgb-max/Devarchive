echo WARNING: All your responses to the script should be written lowercase.

echo Installing GTK greeter...
pacman -S lightdm-gtk-greeter numlockx --noconfirm
echo Installed!

cat>>/etc/lightdm/lightdm.conf<<_eof
[Seat:*]
greeter-session=lightdm-gtk-greeter
_eof

echo If you want to use autologin with your user, paste in here the key provided by the previous script, or press Enter to skip
read _none
if [[ $_none -ne '' ]];then
user=$(echo $_none|base64 -d)

#? CLI autologin
sed 's/^greeter-session=lightdm-gtk-greeter/greeter-session=lightdm-gtk-greeter\nautologin-user=username/'
echo Successfully set up CLI autologin.

#? GUI autologin
sed 's/^#%PAM-1.0/#%PAM-1.0\nauth        sufficient  pam_succeed_if.so user ingr
oup nopasswdlogin/' /etc/pam.d/lightdm
echo Successfully set up GUI autologin \(via PAM\).

#? Add required groups to the user
groupadd -r autologin;gpasswd -a $user autologin
groupadd -r nopasswdlogin;gpasswd -a $user nopasswdlogin
fi
echo Autologin is set up.

#? Numlock on at the startup
sed 's/^greeter-session=lightdm-gtk-greeter/greeter-session=lightdm-gtk-greeter\ngreeter-setup-script=/usr/bin/numlockx on' /etc/pam.d/lightdm
echo Successfully set up GUI autologin \(via PAM\).

echo Successfully set up LightDM!.