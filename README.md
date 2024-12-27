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
You're in the colorful (zsh) prompt again. Type this, and take out the installation media once pc is off. Then feel free to boot into your new system!
```bash
shutdown -h now
```

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
You're in the colorful (zsh) prompt again. Type this, and take out the installation media once pc is off. Then feel free to boot into your new system!
```bash
cd ~
umount -a
shutdown -h now
```
