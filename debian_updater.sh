#!/bin/bash
# All in one debian package update-upgrade-remove-cleaner

sudo apt update && echo -e "[\e[32m+\e[0m]\e[32mOK\e[0m\n"
sudo apt upgrade -y && echo -e "[\e[32m+\e[0m]\e[32mOK\e[0m\n"
sudo apt dist-upgrade -y && echo -e "[\e[32m+\e[0m]\e[32mOK\e[0m\n"
sudo apt autoremove -y && sudo apt clean && echo -e "[\e[32m+\e[0m]\e[32mOK\e[0m\n"
