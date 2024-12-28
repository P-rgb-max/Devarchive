# Welcome to DevArch-ive!

Hello, this is my little guide to installing Arch-linux using my simple scripts to get a highly flexible, Linux for developers.

To get started, you better choose do you want to work in TTY mode or with LXDE graphical environment.

## CLI Mode

#### Live environment
To get started, run this command in the live environment of the Archiso:
```bash
curl https://raw.githubusercontent.com/P-rgb-max/Devarchive/refs/heads/main/cli.sh | bash
```

#### Chrooted system
Then, once asked, run the following lines:
```bash
curl https://raw.githubusercontent.com/P-rgb-max/Devarchive/refs/heads/main/cli_chroot.sh | bash
```

#### Cleaning up
Run these commands, and take out the installation media once your PC is off. Then feel free to boot into your new system!
```bash
exit
umount -a
shutdown -h now
```

**PS.** Once in the new system, run `nmtui` to setup _WiFi connection_. And if you want to double the font, run `setfont -d` (font was doubled along all the installation process).

## GUI mode

#### Live environment
To get started, run this command in the live environment of the Archiso:
```bash
curl https://raw.githubusercontent.com/P-rgb-max/Devarchive/refs/heads/main/gui.sh | bash
```

#### Chrooted system
Then, once asked, run the following lines:
```bash
curl https://raw.githubusercontent.com/P-rgb-max/Devarchive/refs/heads/main/gui_chroot.sh | bash
```

#### Cleaning up
**WARNING:** If you left the default `lightdm` display manager, follow its setup in the misc section of this file before running any commands in this section.

Run this commands, and take out the installation media once your PC is off. Then feel free to boot into your new system!
```bash
exit
umount -a
shutdown -h now
```

## Miscellaneous

#### LightDM setup

I don't know your case, but for me lightdm didn't work right from the start, so either use `sddm` instead (edit gui_chroot.sh:53) or run the setup script with the next commands:
```bash
curl https://raw.githubusercontent.com/P-rgb-max/Devarchive/refs/heads/main/misc/cli.sh | bash
```

The second way is recommended.
