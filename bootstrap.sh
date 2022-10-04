#!/bin/sh 
if [ $(id -u) -ne 0 ]
then 
	>&2 echo "error: please run the script with sudo permissions"
	exit
fi

os_name=$(head -1 /etc/os-release | cut -d "=" -f 2 | tr -d '"')

# OS specific config
case $os_name in
	"Ubuntu")
		cat ppa_list | xargs add-apt-repository -y
		apt update && cat packages_list | xargs apt install -y 
		;;
esac

# wsl specific config
if [ -n "$(uname -a | grep -i "microsoft")" ] 
then
	# im sorry
	username=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2> /dev/null | tr -d '\r' )
	# https://superuser.com/a/1676775
	if [ ! -f /etc/wsl.conf ]
	then
		cat << EOF | tee -a /etc/wsl.conf
[automount]
options = "metadata,umask=022,fmask=111"
EOF
	fi

	# https://x410.dev/cookbook/wsl/sharing-windows-fonts-with-wsl/
	if [ ! -f /etc/fonts/local.conf ]
	then
		echo "integrating windows fonts inside wsl..."
		cat << EOF | tee -a /etc/fonts/local.conf
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <dir>/mnt/c/Windows/Fonts</dir>
    <dir>/mnt/c/Users/$username/AppData/Local/Microsoft/Windows/Fonts</dir>
</fontconfig>
EOF
		fc-cache && echo "done!"
	fi

	# https://superuser.com/questions/1183176/can-i-share-my-ssh-keys-between-wsl-and-windows
	if [ ! -d "/home/$SUDO_USER/.ssh" ]
	then
		echo "integrating windows ssh keys..."
		# create .ssh directory in home directory with proper permissions
		mkdir -m 700 "/home/$SUDO_USER/.ssh"
		# add a permanent mount entry for Windows user .ssh directory
		[ -n $(grep "ssh" /etc/fstab) ] && cat << EOF | sudo tee -a /etc/fstab
C:\Users\\$username\.ssh\ /home/$SUDO_USER/.ssh drvfs rw,noatime,uid=1000,gid=1000,case=off,umask=0077,fmask=0177 0 0
EOF
		# mount .ssh
		mount /home/$SUDO_USER/.ssh && echo "done!"
	fi	
fi

# symlink all packages
find . -maxdepth 1 -type d -not -path '*/.*' -not -path '.' -execdir basename {} \; | xargs -I {} stow -Sv {}

# fish setup
# change shell to fish
chsh -s /usr/bin/fish

# fisher install
fish bootstrap_fish.fish

