#!/usr/bin/env sh
mirage=$(echo "$PWD" | sed 's_/_\\/_g')

sed -i -e 's/ZSH_THEME=.*/ZSH_THEME="mirage"/g' ~/.zshrc
sed -i -e 's/.*ZSH_CUSTOM=.*/ZSH_CUSTOM='"$mirage"'/g' ~/.zshrc
