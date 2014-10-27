#!/bin/sh

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m'

function error_exit
{
	echo -e "${red}ERROR:${NC}"
	echo $1
	exit 1;
}

echo -e "${green}Install pathogen..."
./install_pathogen.sh > /dev/null || error_exit "${red}Could not install pathogen!${NC}"
echo -e "${green}Retrieving plugins...${NC}"
git submodule update --init > /dev/null || error_exit "${red}Failed to get plugins!${NC}"
echo -e "${green}Linking .vimrc to home directory...${NC}"
./link_rc.sh || error_exit "${red}Failed to setup .vimrc${NC}"
echo -e "${green}Done!${NC}"
