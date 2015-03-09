# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

# Set my umask depending on whether it looks like I own my group.
if [ "$(id -un)" = "$(id -gn)" ]
then umask 027
else umask 077
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private /usr/bin if it exists
if [ -d "$HOME/usr/bin" ] ; then
    PATH="$HOME/usr/bin:$PATH"
fi

# set MANPATH so it includes user's private /usr/share/man if it exists
if [ -d "$HOME/usr/share/man" ] ; then
    MANPATH="$HOME/usr/share/man:$MANPATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export PATH=/opt/Sencha/Cmd/5.1.1.39:$PATH

export SENCHA_CMD_3_0_0="/opt/Sencha/Cmd/5.1.1.39"
