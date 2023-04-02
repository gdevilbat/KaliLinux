FROM kalilinux/kali-rolling:latest

# Define build arguments
ARG USER_ID
ARG GROUP_ID
ARG USER_NAME
ARG PW=docker


# Define environment variables
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID
ENV USER_NAME=$USER_NAME
#ENV USER_ID=${USER_ID:-1001}
#ENV GROUP_ID=${GROUP_ID:-1001}

RUN useradd -m ${USER_NAME} --uid=${USER_ID} && echo "${USER_NAME}:${PW}" | \
      chpasswd

# Add group and user based on build arguments
# RUN addgroup --gid ${GROUP_ID} ${USER_NAME}
# RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} ${USER_NAME}


COPY ./docker/deb9.list /etc/apt/sources.list.d/deb9.list

RUN apt update && apt update --fix-missing && apt upgrade -y \
    && apt install dialog software-properties-common ssh sudo -y \
    && apt install nano htop unzip man curl whois iputils-ping wget telnet net-tools freeradius-utils ftp iproute2 netcat python3-tk pciutils kmod ncurses-hexedit -y \
    && apt install dbus-x11 libcanberra-gtk-module libcanberra-gtk3-module firefox-esr -y \
    && apt install sqlmap dirsearch dnsenum nmap burpsuite metasploit-framework wordlists hydra powershell-empire apktool aircrack-ng -y \
    && apt install openjdk-8-jre openjdk-11-jdk libwebkitgtk-1.0-0 -y \
    && apt install libqt5multimedia5 libqt5webenginewidgets5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libqt5webenginecore5 libqt5quick5 libqt5gui5 libqt5networkauth5 libqt5websockets5 libqt5qmlmodels5 libqt5webchannel5 libqt5qml5 libqt5network5 libqt5xml5 libqt5script5 libqt5scripttools5 libqt5sql5 libqt5positioning5 -y



# export LIBGL_ALWAYS_SOFTWARE=1

# Generating a universally unique ID for the Container
RUN  dbus-uuidgen > /etc/machine-id

RUN usermod -aG sudo ${USER_NAME}

WORKDIR /home
USER ${USER_ID}:${GROUP_ID}
WORKDIR /home/${USER_NAME}