FROM kalilinux/kali-rolling:latest

COPY ./docker/deb9.list /etc/apt/sources.list.d/deb9.list

RUN apt update && apt upgrade -y \
    && apt install dialog software-properties-common ssh -y \
    && apt install nano htop unzip man curl whois iputils-ping wget telnet net-tools freeradius-utils ftp iproute2 netcat -y \
    && apt install dbus-x11 libcanberra-gtk-module libcanberra-gtk3-module firefox-esr -y \
    && apt install sqlmap dirsearch dnsenum nmap burpsuite metasploit-framework wordlists hydra -y \
    && apt install openjdk-8-jre libwebkitgtk-1.0-0 -y \
    && apt install libqt5multimedia5 libqt5webenginewidgets5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libqt5webenginecore5 libqt5quick5 libqt5gui5 libqt5networkauth5 libqt5websockets5 libqt5qmlmodels5 libqt5webchannel5 libqt5qml5 libqt5network5 libqt5xml5 libqt5script5 libqt5scripttools5 libqt5sql5 libqt5positioning5 -y


WORKDIR /home

# export LIBGL_ALWAYS_SOFTWARE=1

# Generating a universally unique ID for the Container
RUN  dbus-uuidgen > /etc/machine-id