# Dotfiles

A minimalist, personal collection of configuration files optimized for a resource-efficient workflow across Fedora Linux and macOS. 

## Overview
This repository manages my core terminal environment and tooling configurations. It relies on [GNU Stow](https://www.gnu.org/software/stow/) to handle symlinking these configuration files directly into the home directory, keeping the system clean and the dotfiles easily version-controlled.


## Prerequisites
Before deploying, ensure the following are installed on your system:
* `git`
* `stow`

## Installation

1. **Clone the repository** into your home directory:

        git clone https://github.com/singhc7/dotfiles.git ~/.dotfiles
        cd ~/.dotfiles

2. **Deploy configurations** using Stow. Run this command for each piece of software you want to configure:

        stow zsh
        stow alacritty

*Note: Stow will automatically create symlinks from the folders in this repository to their appropriate locations in your home directory.*
