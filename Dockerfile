FROM ubuntu:latest

# these can only be changed only at image build time
ENV VNC_PORT 5900
ENV V_USER xfce4
ENV V_UID 1000
ENV V_GID 1000
ENV TZ Asia/Jerusalem
ENV OPTIONAL_APT transmission-remote-gtk openssh-client

# install packages
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates curl openssl sudo bash xvfb x11vnc xfce4 faenza-icon-theme wget $OPTIONAL_APT

# install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm -f ./google-chrome-stable_current_amd64.deb

# cleanup
RUN apt clean -y

# these can be changed at runtime or via docker-compose
ENV DISPLAY :5
ENV RESOLUTION 1920x1080x24
ENV VNC_PASSWORD pleasechange

# copy script
COPY entry.sh /entry.sh

# set time zone
RUN echo $V_TIMEZONE > /etc/timezone

# create user not to run as root
RUN addgroup --gid $V_GID $V_USER
RUN adduser --home /home/$V_USER --shell /bin/bash --system --disabled-password --uid $V_UID --gid $V_GID $V_USER && \
    echo "$V_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
    cat /etc/sudoers

USER $V_USER
WORKDIR /home/$V_USER

EXPOSE $VNC_PORT

CMD [ "/bin/bash", "/entry.sh" ]
