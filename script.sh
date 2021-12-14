# Variables
USERNAME="andreas"


# MAKE apt ready to install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
apt -y --allow-unauthenticated install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

# Make apt ready for onedriver
echo 'deb http://download.opensuse.org/repositories/home:/jstaf/xUbuntu_21.04/ /' | tee /etc/apt/sources.list.d/home:jstaf.list
curl -fsSL https://download.opensuse.org/repositories/home:jstaf/xUbuntu_21.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_jstaf.gpg > /dev/null

# Update
apt -y --allow-unauthenticated update

# List of packages to be installed
PACKAGE_LIST=(
	'gnome-tweaks'
	'gnome-startup-applications'
	'gnome-shell-extensions'
	'steam'
	'discord'
	'lutris'
	'vlc'
	'python3-pip'
	'pavucontrol' # Multiple audio outputs
	'sublime-text' # Requires dependancies
	'onedriver' # Requires dependancies
)
# Install Packages
for PACKAGE in ${PACKAGE_LIST[@]}; do
	echo "INSTALLING: ${PACKAGE}"
	apt -y --allow-unauthenticated install "${PACKAGE}"
done

timedatectl set-local-rtc 1 # Set time to real time clock (sync for dual boot)

# Update and Upgrade
apt -y --allow-unauthenticated update 
apt upgrade -y --allow-unauthenticated

echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

printf "function acpp() {\ngit add .;\ngit commit -m "\$1";\ngit pull;\ngit push;}" >> /home/andreas/.bashrc
. /home/andreas/.bashrc


# Multiple sound devices
mkdir -p  home/andreas/.local/share/gnome-shell/extensions/
cd home/andreas/.local/share/gnome-shell/extensions/
git clone https://github.com/kgshank/gse-sound-output-device-chooser.git
cp -r gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net .
rm -rf "gse-sound-output-device-chooser"
