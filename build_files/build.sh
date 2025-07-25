#!/bin/bash

set -ouex pipefail

# Add and verify rpmfusion repos
dnf5 -y in distribution-gpg-keys && \
rpmkeys --import /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-free-fedora-$(rpm -E %fedora) && \
rpmkeys --import /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$(rpm -E %fedora) && \
dnf5 -y --setopt=localpkg_gpgcheck=1 in https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
										https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### Install packages for codecs and hardware acceleration
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 -y in libva-intel-driver

# Install packages required by homebrew
dnf5 -y in  @development-tools

### Install packages i want to use
dnf5 -y in  distrobox \
            gnome-tweaks \
            chromium \
            chromedriver 

### Remove packages
dnf5 -y remove  firefox \
                firefox-langpacks \
                gnome-software-rpm-ostree \
                gnome-console \
                yelp

### Post removal cleanup
dnf5 clean all


#### Enabling a System Unit File
# Left this here cause it's on the template

systemctl enable podman.socket
