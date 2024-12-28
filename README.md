# Welcome to DevArch-ive!

Hello, this is my little guide to installing Arch-linux using my simple scripts to get a highly flexible, Linux for developers.

To get started, you better choose do you want to work in TTY mode or with LXDE graphical environment.

 - [CLI mode](#cli)
 - [GUI mode](#gui)

## CLI Mode

#### Live environment
To get started, run this command in the live environment of the Archiso:
```bash
cd ~
umount -a
curl <raw cli.sh url> | bash
```

#### Chrooted system
Then, once asked, run the following lines:
```bash
curl <raw cli_chroot.sh url> | bash
```

#### Cleaning up
You're in the colorful (zsh) prompt again. Type this, and take out the installation media once your PC is off. Then feel free to boot into your new system!
```bash
umount -a
shutdown -h now
```

**PS.** Once in the new system, run `nmtui` to setup _WiFi connection_. And if you want to double the font, run `setfont -d` (font was doubled along all the installation process).

## GUI mode

#### Live environment
To get started, run this command in the live environment of the Archiso:
```bash
curl <raw gui.sh url> | bash
```

#### Chrooted system
Then, once asked, run the following lines:
```bash
curl <raw gui_chroot.sh url> | bash
```

#### Cleaning up
**WARNING:** If you left the default `lightdm` display manager, follow its [setup](#lightdm)
You're in the colorful (zsh) prompt again. Type this, and take out the installation media once pc is off. Then feel free to boot into your new system!
```bash
umount -a
shutdown -h now
```

## Miscellaneous

#### LightDM setup

I don't know your case, but for me lightdm didn't work right from the start, so either use `sddm` instead (edit gui_chroot.sh:53) or run the setup script at `misc/lightdm.sh` (recommended).
