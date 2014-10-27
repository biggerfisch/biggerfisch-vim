#!/bin/sh

function error_exit
{
	echo "ERROR:"
	echo $1
	exit 1;
}

echo "Install pathogen..."
./install_pathogen.sh > /dev/null || error_exit "Could not install pathogen!"
echo "Retrieving plugins..."
git submodule update --init > /dev/null || error_exit "Failed to get plugins!"
echo "Linking .vimrc to home directory"
./link_rc.sh || error_exit "Failed to setup .vimrc"
echo "Done!"
