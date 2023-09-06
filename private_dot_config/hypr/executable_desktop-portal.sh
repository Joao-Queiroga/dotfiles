#!/bin/sh
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-gtk -r &
/usr/libexec/xdg-desktop-portal-hyprland -r &
/usr/libexec/flatpak-portal -r &
sleep 2
/usr/libexec/xdg-desktop-portal &
