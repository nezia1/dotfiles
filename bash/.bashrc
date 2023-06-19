#
# ~/.bashrc
#

# make sure ssh related variables are available in non-interactive sessions (useful for emacs' exec-path-from-shell)
[[ -f "$HOME/.keychain/$HOSTNAME-sh" ]] && source "$HOME/.keychain/$HOSTNAME-sh"

# if running interactively, run fish
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
		exec fish $LOGIN_OPTION
fi
