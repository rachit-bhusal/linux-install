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
