#!/bin/sh

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m'

function error_exit
{
	echo -e "${red}ERROR${NC}"
	echo "QUITTING"
	exit 1;
}

echo -e "${green}Installing pathogen..."
./install_pathogen.sh > /dev/null || error_exit "Could not install pathogen!"
echo -e "${green}Retrieving plugins...${NC}"
git submodule update --init > /dev/null || error_exit "Failed to get plugins!"
echo -e "${green}Linking .vimrc to home directory...${NC}"
./link_rc.sh || error_exit "Failed to setup .vimrc"
echo -e "${green}Done!${NC}"
