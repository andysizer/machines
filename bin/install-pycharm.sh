#! /bin/sh

if wget -O ~/Downloads/pycharm-community-2020.1.tar.gz https://download.jetbrains.com/python/pycharm-community-2020.1.tar.gz?_ga=2.22642040.2115496248.1588160682-1490784125.1588160682
then
    echo "extract '~/Downloads/pycharm-community-2020.1.tar.gz' and follow instructions"
else
    echo "pycharm download failed. Go to 'https://www.jetbrains.com/pycharm/download/#section=linux' to download"
fi
