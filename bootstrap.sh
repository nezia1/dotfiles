#!/bin/sh 
if [ $(id -u) -ne 0 ]
then 
	>&2 echo "error: please run the script with sudo permissions"
	exit
fi

# OS specific config
os_name=$(head -1 /etc/os-release | cut -d "=" -f 2 | tr -d '"')

case $os_name in
	"Ubuntu")
		cat ppa_list | xargs add-apt-repository -y
		apt update && cat packages_list | xargs apt install -y 
		;;
esac

if [ -n "$(uname -a | grep -i "microsoft")" ] 
then
	if [ ! -f /etc/wsl.conf ]
	then
		cp wsl.conf /etc/wsl.conf
		echo "integrating windows fonts inside wsl..."
		fc-cache && echo "done!"
	fi

	# im sorry
	# watch out for windows commands in wsl (make sure to translate windows carriage returns to linux otherwise you're going to debug it for hours and lose your mind

	if [ ! -d "/home/$SUDO_USER/.ssh" ]
	then
		# https://superuser.com/questions/1183176/can-i-share-my-ssh-keys-between-wsl-and-windows
		echo "symlinking windows ssh keys with wsl..."
		username=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2> /dev/null | tr -d '\r' )
		# Create .ssh directory in home directory with proper permission
		mkdir -m 700 "/home/$SUDO_USER/.ssh"
		
		# Add a permanent mount entry for Windows user .ssh directory
		cat << EOF | sudo tee -a /etc/fstab
		C:\Users\\$username\.ssh\ /home/$SUDO_USER/.ssh drvfs rw,noatime,uid=1000,gid=1000,case=off,umask=0077,fmask=0177 0 0
EOF
		# Mount the .ssh
		mount /home/$SUDO_USER/.ssh && echo "done!"
	fi	
fi

# symlink all dotfile directories
find . -maxdepth 1 -type d -not -path '*/.*' -not -path '.' -execdir basename {} \; | xargs -I {} stow -Sv {}

# fish setup
# change shell to fish
chsh -s /usr/bin/fish

# powerline install
pip install powerline-status

# fisher install
fish bootstrap_fish.fish


