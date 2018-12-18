#!/bin/bash

if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

# try to load global-bashrc
if [ -f /etc/bashrc ]; then
      . /etc/bashrc
fi

source ~/.bash_profile

