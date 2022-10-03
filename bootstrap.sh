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
		cat packages_list | xargs apt install -y 
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

	if [ ! -d ~/.ssh ] || [ ! -L ~/.ssh ]
	then
		# im sorry
		# watch out for windows commands in wsl (make sure to translate windows carriage returns to linux otherwise you're going to debug it for hours and lose your mind
		username=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2> /dev/null | tr -d '\r' )
		echo "symlinking windows ssh keys with wsl..."
		ln -s "/mnt/c/Users/$username/.ssh" /home/$SUDO_USER/.ssh && echo "done!"
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


