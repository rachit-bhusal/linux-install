archinstall

# root
pacman -S xf86-video-intel nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings linux-headers git nano neovim --needed


sudo nano /etc/pacman.conf

# Misc options uncomment and change and add
Color
CheckSpace
VerbosePkgLists
ParallelDownloads = 10
ILoveCandy


sudo nano /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 rd.driver.blacklist=nouveau modprob.blacklist=nouveau"
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo nano /etc/mkinitcpio.conf
MODULES(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)
sudo mkinitcpio -P


sudo mkdir /etc/pacman.d/hooks
sudo nano /etc/pacman.d/hooks/nvidia.hook

[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
Exec=/usr/bin/mkinitcpio -P


sudo nano /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

 Section "OutputClass"
    Identifier "intel"
    MatchDriver "i915"
    Driver "modesetting"
 EndSection

Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "PrimaryGPU" "yes"
    ModulePath "/usr/lib/nvidia/xorg"
    ModulePath "/usr/lib/xorg/modules"
EndSection


# if sddm
sudo pacman -S plasma sddm
sudo nano /usr/share/sddm/scripts/Xsetup
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
sudo systemctl enable sddm.service

reboot

# sudo user not root
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -Yc
yay
sudo pacman -Syu

# as root
pacman -S i3 xorg-server xorg-xrandr xorg-xinit
pacman -S kitty firefox dmenu pavucontrol thunar brightnessctl neofetch

sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
# delete last lines then
exec i3

startx

sudo timedatectl set-timezone 'Asia/Kathmandu'
nmcli device wifi list
nmcli device wifi connect Rara/Rara-5 password '***********'

lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    0 931.5G  0 disk
└─sda1        8:1    0 931.5G  0 part
zram0       254:0    0     4G  0 disk [SWAP]
nvme0n1     259:0    0 476.9G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot
└─nvme0n1p2 259:2    0 476.4G  0 part /var/log
                                      /var/cache/pacman/pkg
                                      /home
                                      /.snapshots
                                      /
mount -t ntfs3 /dev/sda1 /mnt

sudo nano /etc/resolv.conf

neofetch

                   -`                    rachit@iusearchbtw
                  .o+`                   ------------------
                 `ooo/                   OS: Arch Linux x86_64
                `+oooo:                  Host: Predator PH315-52 V1.12
               `+oooooo:                 Kernel: 6.5.6-arch2-1
               -+oooooo+:                Uptime: 57 mins
             `/:-:++oooo+:               Packages: 542 (pacman)
            `/++++/+++++++:              Shell: zsh 5.9
           `/++++++++++++++:             Resolution: 1920x1080, 1920x1080
          `/+++ooooooooooooo/`           WM: i3
         ./ooosssso++osssssso+`          Theme: Adwaita [GTK3]
        .oossssso-````/ossssss+`         Icons: Adwaita [GTK3]
       -osssssso.      :ssssssso.        Terminal: kitty
      :osssssss/        osssso+++.       CPU: Intel i7-9750H (12) @ 4.500GHz
     /ossssssss/        +ssssooo/-       GPU: NVIDIA GeForce GTX 1660 Ti Mobile
   `/ossssso+/:-        -:/+osssso+-     GPU: Intel CoffeeLake-H GT2 [UHD Graphics
  `+sso+:-`                 `.-/+oso:    Memory: 3677MiB / 15832MiB
 `++:.                           `-/+/
 .`                                 `/

sudo pacman -S fwupd
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y
sudo fwupdmgr get-upgrades -y
sudo fwupdmgr upgrade -y

sudo pacman -S intel-undervolt
sudo nano /etc/intel-undervolt.conf

undervolt 0 'CPU' -133
undervolt 1 'GPU' -134
undervolt 2 'CPU Cache' -134
undervolt 3 'System Agent' 0
undervolt 4 'Analog I/O' 0

sudo intel-undervolt apply
sudo systemctl enable intel-undervolt.service

sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

git config --global user.name "Rachit Bhusal"
git config --global user.email rachitbhusal@gmail.com

sudo pacman -S openssh
ssh-keygen -t ed25519 -C "rachitbhusal@gmail.com"
sudo cat ~/.ssh/id_ed25519.pub

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node # "node" is an alias for the latest version

yay -S visual-studio-code-bin ttf-victor-mono-nerd ttf-jetbrains-mono-nerd
yay -S stremio spotify

# yay pacman commands
yay Alias to yay -Syu.
yay <Search Term> 	Present package-installation selection menu.
yay -Bi <dir> 	Install dependencies and build a local PKGBUILD.
yay -G <AUR Package> 	Download PKGBUILD from ABS or AUR. (yay v12.0+)
yay -Gp <AUR Package> 	Print to stdout PKGBUILD from ABS or AUR.
yay -Ps 	Print system statistics.
yay -Syu --devel 	Perform system upgrade, but also check for development package updates.
yay -Syu --timeupdate 	Perform system upgrade and use PKGBUILD modification time (not version number) to determine update.
yay -Wu <AUR Package> 	Unvote for package (Requires setting AUR_USERNAME and AUR_PASSWORD environment variables) (yay v11.3+)
yay -Wv <AUR Package> 	Vote for package (Requires setting AUR_USERNAME and AUR_PASSWORD environment variables). (yay v11.3+)
yay -Y --combinedupgrade --save 	Make combined upgrade the default mode.
yay -Y --gendb 	Generate development package database used for devel update.
yay -Yc 	Clean unneeded dependencies.

# To remove a package, its dependencies and all the packages that depend on the target package:
pacman -Rsc package_name
