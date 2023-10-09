sudo nano /etc/dnf/dnf.conf
max_parallel_downloads=10
fastestmirror=1
deltarpm=true
keepcache=true
countme=false

sudo dnf remove -y cheese gnome-classic-session hyperv* gnome-shell-extension-background-logo gnome-boxes gnome-contacts gnome-tour gnome-logs gnome-maps yelp gnome-calculator simple-scan sane* fedora-bookmarks fedora-chromium-config gnome-tour gnome-shell-extension* totem mediawriter gnome-connections firefox gnome-user-docs rhythmbox mozilla-filesystem gnome-text-editor gedit evince*  gnome-photos baobab

sudo dnf remove fedora-bookmarks fedora-chromium-config firefox mozilla-filesystem anaconda* *speech* *zhuyin* *pinyin* *m17n* *hangul* *anthy* words podman* *libvirt* open-vm* qemu-guest-agent hyperv* spice-vdagent virtualbox-guest-additions xorg-x11-drv-vmware xorg-x11-drv-amdgpu rhythmbox document-scanner sane* gnome-user-docs gnome-connections *yelp* gnome-text-editor *evince* libreoffice* cheese mediawriter gnome-tour gnome-themes-extra gnome-remote-desktop gnome-font-viewer gnome-calculator gnome-calendar gnome-contacts gnome-maps gnome-weather gnome-logs gnome-disk-utility gnome-clocks gnome-color-manager gnome-characters baobab totem gnome-shell-extension-background-logo gnome-shell-extension-apps-menu gnome-shell-extension-launch-new-instance gnome-shell-extension-places-menu gnome-shell-extension-window-list gnome-classic* eog* gnome-backgrounds gnome-tour gnome-themes-extra gnome-screenshot gnome-remote-desktop gnome-font-viewer gnome-calculator gnome-calendar gnome-contacts gnome-maps gnome-weather gnome-logs gnome-boxes gnome-disk-utility gnome-clocks gnome-color-manager gnome-characters baobab totem gnome-shell-extension-background-logo gnome-shell-extension-apps-menu gnome-shell-extension-horizontal-workspaces gnome-shell-extension-launch-new-instance gnome-shell-extension-places-menu gnome-shell-extension-window-list gnome-classic* gnome-user* chrome-gnome-shell

# (remove steam and google-chrome)
cd /etc/yum.repos.d

rm -rf /.mozilla

install nvidia drivers

sudo dnf check-update
sudo dnf clean all
sudo dnf -y update && sudo dnf upgrade -y --refresh

sudo dnf clean all
sudo dnf autoremove -y

sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y
sudo fwupdmgr get-upgrades -y
sudo fwupdmgr upgrade -y

reboot

sudo dnf install intel-undervolt
sudo nano /etc/intel-undervolt.conf

undervolt 0 'CPU' -133
undervolt 1 'GPU' -133
undervolt 2 'CPU Cache' -133
undervolt 3 'System Agent' 0
undervolt 4 'Analog I/O' 0

sudo intel-undervolt apply

sudo systemctl enable intel-undervolt.service

sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

git config --global user.name "Rachit Bhusal"
git config --global user.email rachitbhusal@gmail.com

ssh-keygen -t ed25519 -C "rachitbhusal@gmail.com"
sudo cat ~/.ssh/id_ed25519.pub

flatpak update
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.wwmm.easyeffects
flatpak update

#!/bin/sh

# Configure dnf (In order: automatically select fastest mirror, parallel downloads, and disable telemetry)
# fastestmirror=1
printf "%s" "
max_parallel_downloads=10
countme=false
" | sudo tee -a /etc/dnf/dnf.conf

# echo 'Make sure your system has been fully-updated by running "sudo dnf upgrade -y" and reboot it once.'
sudo dnf upgrade -y

#Setting umask to 077
# No one except wheel user and root get read/write files
umask 077
sudo sed -i 's/umask 002/umask 077/g' /etc/bashrc
sudo sed -i 's/umask 022/umask 077/g' /etc/bashrc

# Debloat
sudo dnf remove -y abrt* adcli anaconda* cheese dmidecode gnome-classic-session anthy-unicode avahi baobab bluez-cups brasero-libs trousers hyperv* alsa-sof-firmware boost-date-time gnome-calendar gnome-shell-extension-background-logo gnome-weather gnome-boxes gnome-clocks gnome-contacts gnome-tour gnome-logs gnome-remote-desktop gnome-maps gnome-backgrounds virtualbox-guest-additions yelp gnome-calculator gnome-characters gnome-system-monitor gnome-font-viewer gnome-font-viewer simple-scan evince-djvu orca fedora-bookmarks fedora-chromium-config mailcap open-vm-tools openconnect openvpn ppp pptp qgnomeplatform rsync samba-client unbound-libs vpnc podman yajl zd1211-firmware atmel-firmware libertas-usb8388-firmware linux-firmware gnome-tour gnome-shell-extension* totem mediawriter gnome-connections nano nano-default-editor firefox xorg-x11-drv-vmware sane* perl* thermald NetworkManager-ssh sos kpartx dos2unix gnome-user-docs sssd cyrus-sasl-plain gnome-color-manager geolite2* traceroute mtr realmd gnome-themes-extra ModemManager teamd tcpdump mozilla-filesystem nmap-ncat spice-vdagent eog gnome-text-editor perl-IO-Socket-SSL evince

# Verify systemd-oomd works
# systemctl status systemd-oomd

# Run Updates
sudo dnf autoremove -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

# Configure GNOME
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
#gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-seconds true
#gsettings set org.gnome.desktop.screensaver.lock-enabled false
#gsettings set org.gnome.desktop.notifications.show-in-lock-screen false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# Setup Flathub and Flatpak
# Flathub is enabled by default, but fails to install anything outside of Fedora still.
# Alternatively you can enable third party repos at install, but this clutters dnf with NVIDIA and Chrome.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# Setup RPMFusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core -y

# Install things I need
flatpak install -y flathub com.transmissionbt.Transmission org.mozilla.firefox org.signal.Signal org.libreoffice.LibreOffice ch.protonmail.protonmail-bridge com.github.tchx84.Flatseal org.bleachbit.BleachBit org.getmonero.Monero org.gnome.Loupe org.keepassxc.KeePassXC com.brave.Browser org.gnome.Evolution com.github.micahflee.torbrowser-launcher org.inkscape.Inkscape io.freetubeapp.FreeTube net.mullvad.MullvadBrowser org.getmonero.Monero re.sonny.Junction com.tutanota.Tutanota com.protonvpn.www com.obsproject.Studio com.usebottles.bottles com.obsproject.Studio.Plugin.OBSVkCapture app.drey.Warp org.pipewire.Helvum org.freedesktop.Platform.VulkanLayer.OBSVkCapture net.davidotek.pupgui2 com.heroicgameslauncher.hgl com.valvesoftware.Steam org.freedesktop.Platform.VulkanLayer.MangoHud org.gnome.Calculator org.gnome.gitlab.YaLTeR.VideoTrimmer org.gnome.Extensions org.gnome.Characters org.blender.Blender org.gnome.Evince
sudo dnf install -y steam-devices neovim sqlite3 zsh-autosuggestions zsh-syntax-highlighting setroubleshoot newsboat ffmpeg compat-ffmpeg4 akmod-v4l2loopback yt-dlp @virtualization distrobox podman hugo --best --allowerasing

# Initialize virtualization
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $(whoami)

# Cockpit is still missing some core functionality, but will switch when it is added.
#sudo systemctl enable cockpit.socket --now

# Install Sway
# sudo dnf install -y sway waybar wlsunset network-manager-applet

# Harden the Kernel with Kicksecure's patches
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/modprobe.d/30_security-misc.conf -o /etc/modprobe.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_security-misc.conf -o /etc/sysctl.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_silent-kernel-printk.conf -o /etc/sysctl.d/30_silent-kernel-printk.conf

# Enable Kicksecure CPU mitigations
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_cpu_mitigations.cfg -o /etc/grub.d/40_cpu_mitigations.cfg
# Kicksecure's CPU distrust script
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_distrust_cpu.cfg -o /etc/grub.d/40_distrust_cpu.cfg
# Enable Kicksecure's IOMMU patch (limits DMA)
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_enable_iommu.cfg -o /etc/grub.d/40_enable_iommu.cfg

# Divested's brace patches
# Sandbox the brace systemd permissions
# If you have VPN issues: https://old.reddit.com/r/DivestOS/comments/12b4fk4/comment/jex4qt2/
sudo mkdir -p /etc/systemd/system/NetworkManager.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/NetworkManager.service.d/99-brace.conf -o /etc/systemd/system/NetworkManager.service.d/99-brace.conf
sudo mkdir -p /etc/systemd/system/irqbalance.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/irqbalance.service.d/99-brace.conf -o /etc/systemd/system/irqbalance.service.d/99-brace.conf

# GrapheneOS's ssh limits
# caps the system usage of sshd
# GrapheneOS has changed the way this is implemented, so I'm working on a reintegration.
# sudo mkdir -p /etc/systemd/system/sshd.service.d
# sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/systemd/system/sshd.service.d/limits.conf -o /etc/systemd/system/sshd.service.d/limits.conf
# echo "GSSAPIAuthentication no" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
# echo "VerifyHostKeyDNS yes" | sudo tee -a /etc/ssh/ssh_config.d/10-custom.conf

# NTS instead of NTP
# NTS is a more secured version of NTP
sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/chrony.conf -o /etc/chrony.conf

# Remove Firewalld's Default Rules
sudo firewall-cmd --permanent --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --remove-port=1025-65535/tcp
sudo firewall-cmd --permanent --remove-service=mdns
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

#Randomize MAC address and disable static hostname. This could be used to track general network activity.
sudo bash -c 'cat > /etc/NetworkManager/conf.d/00-macrandomize.conf' <<-'EOF'
[main]
hostname-mode=none

[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
EOF

sudo systemctl restart NetworkManager
sudo hostnamectl hostname "localhost"

# Disable Bluetooth
sudo systemctl disable bluetooth

# Enable DNSSEC
# causes severe network instability, but working on getting this up and running
# sudo sed -i s/#DNSSEC=no/DNSSEC=yes/g /etc/systemd/resolved.conf
# sudo systemctl restart systemd-resolved

# Make the Home folder private
# Privatizing the home folder creates problems with virt-manager
# accessing ISOs from your home directory. Store images in /var/lib/libvirt/images
chmod 700 /home/"$(whoami)"
# is reset using:
#chmod 755 /home/"$(whoami)"
#
# DaVinci Resolve tweaks
# Because no one ever said how to in detail
# I'm sorry GE, but this might as well be nonsense to normies: https://old.reddit.com/r/Fedora/comments/12g0mh4/fedora_38_issue_with_davinci_resolve/
# sudo dnf install mesa-Glu
#sudo cp /lib64/libglib-2.0.so.0* /opt/resolve/libs

echo "The configuration is now complete."


#!/bin/sh
#
# Installs and automatically signs the NVIDIA driver for UEFI secure boot
# Sauce: https://rpmfusion.org/Howto/Secure%20Boot
# This also causes a "false flag" with GNOME/KDE's security menu, although it's not wrong.
# Your system must be installed with UEFI enabled out of the box, which if you have Secure
# Boot enabled prior to the installation, it works great.
sudo dnf install kmodtool akmods openssl -y
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
echo "Reboot, enter your key's password, then run script 2."

#!/bin/sh
#
# Installs NVIDIA driver
# Requires RPMFusion
# Source: https://rpmfusion.org/Howto/NVIDIA
sudo dnf install kmod-nvidia xorg-x11-drv-nvidia-cuda akmod-nvidia nvidia-vaapi-driver libva-utils vdpauinfo
echo "
    Open grub config sudoedit /etc/default/grub
    Add nvidia-drm.modeset=1 to GRUB_CMDLINE_LINUX line
    Update grub config with sudo grub2-mkconfig -o /boot/grub2/grub.cfg command
    Reboot the system
"

