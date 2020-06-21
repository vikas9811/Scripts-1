#!/usr/bin/env bash

#For Ubuntu 20.4/Linux 19.3 or greater; you may try on other distros.
echo "Setting up your build environment for you."
echo "Leave these menial tasks to us gremlins...this can take a few minutes."
echo ""

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python2.7 python3 -y

#Downloading repo
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

#Downloading and unzipping platform tools
wget -O platform-tools.zip https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools.zip -d ~
rm -rf platform-tools.zip

#Enabling platform tools by adding it to the path
cat <<EOT >> .profile

# add Android SDK platform tools to path
if [ -d "${HOME}/platform-tools" ] ; then
    PATH="${HOME}/platform-tools:$PATH"
fi
EOT
source ~/.profile

#Setting up git
GIT_USERNAME=$(git config --get user.name)
GIT_EMAIL=$(git config --get user.email)
if [[ -z ${GIT_USERNAME} ]]; then
    echo "Please enter the name and email address of your git account"
    echo "By the way, it wont be verified :)"
    echo ""
    echo -n "Enter your name: "
    read -r NAME
    git config --global user.name "${NAME}"
fi
if [[ -z ${GIT_EMAIL} ]]; then
    echo -n "Enter your email: "
    read -r EMAIL
    git config --global user.email "${EMAIL}"
fi
echo "Git account has been setup."

sudo apt-get update && sudo apt-get upgrade -y

#Just gonna do this again because sometimes it fails the first time
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python2.7 python3 -y

echo ""
echo "Your environment is ready. Happy developing!"
echo ""
echo "Press 'enter' to exit..."

read
