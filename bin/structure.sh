#!/bin/bash

# Setup my actual folder architecture, as I liked.
# Because I don't like to use mkdir / COPY PAST

# SETUP My own bash profile
if [ ! -z "$USER" ]
    cp .bash_profile /home/$USER/.bash_profile
fi