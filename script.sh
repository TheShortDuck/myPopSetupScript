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
	'grub-efi'
	'grub2-common'
	'grub-customizer'
	'gnome-tweaks'
	'gnome-starttup-applications'
	'steam'
	'discord'
	'lutris'
	'vlc'
	'pavucontrol' # Multiple audio outputs
	'sublime-text' # Requires dependancies
	'onedriver' # Requires dependancies
)
# Install Packages
for PACKAGE in "{PACKAGE_LIST[@]}"; do
	echo "INSTALLING: ${PACKAGE}"
	apt -y --allow-unauthenticated install "${PACKAGE}"
done

timedatectl set-local-rtc 1 # Set time to real time clock (sync for dual boot)

grub-install # start grub

# Update and Upgrade
apt -y --allow-unauthenticated update 
apt upgrade -y --allow-unauthenticated

echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

printf "function acpp() {\ngit add .;\ngit commit -m "\$1";\ngit pull;\ngit push;}" >> ~/.bashrc
. ~/.bashrc