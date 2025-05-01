#!/bin/bash
current=$(powerprofilesctl get)

if [ "$current" = "performance" ]; then
  powerprofilesctl set balanced
elif [ "$current" = "balanced" ]; then
  powerprofilesctl set power-saver
else
  powerprofilesctl set performance
fi
