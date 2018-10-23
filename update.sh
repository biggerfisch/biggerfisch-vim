#!/bin/sh

#This script updates all the vim plugins 

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m'

function error_exit
{
	echo -e "${red}ERROR${NC}"
	echo "$1"
	echo "QUITTING"
	exit 1;
}

git pull 

git submodule init || error_exit 'Could not init submodules'
git submodule foreach git checkout master || error_exit 'Could not checkout master on one or more plugins!'
git submodule foreach git pull --ff || error_exit 'Could not update one or more plugins'
git submodule foreach git submodule update --init --recursive || error_exit "Could not update plugin reqs"

cd bundle/YouCompleteMe/ && ./install.py && cd ../../
cd bundle/tern_for_vim/ && npm install && rm package-lock.json && cd ../../
echo -e "${green}Done!${NC}"
