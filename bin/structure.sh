#!/bin/bash

# Setup my actual folder architecture, as I liked.
# Because I don't like to use mkdir / COPY PAST

# SETUP My own bash profile
if [ ! -z "$INSTALL_USER" ]; then
    cp .bash_profile /home/"$INSTALL_USER"/.bash_profile
    chown -R "$INSTALL_USER":"$INSTALL_USER" /home/"$INSTALL_USER"/.bash_profile
fi