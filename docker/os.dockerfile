FROM kalilinux/kali-rolling:latest

COPY ./docker/deb9.list /etc/apt/sources.list.d/deb9.list

RUN apt update && apt upgrade -y \
    && apt install dialog -y \
    && apt install software-properties-common nano htop unzip sqlmap -y \
    && apt install dbus-x11 libcanberra-gtk-module libcanberra-gtk3-module firefox-esr -y \
    && apt install openjdk-8-jre libwebkitgtk-1.0-0 -y

WORKDIR /home

COPY ./docker/VegaBuild-linux.gtk.x86_64.zip ./VegaBuild-linux.gtk.x86_64.zip

RUN unzip -q VegaBuild*.zip