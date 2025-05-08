#!/bin/bash

set -ouex pipefail
flatpak remote-add --if-not-exists  flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.gnome.Sudoku

