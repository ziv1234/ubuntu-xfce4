FROM ubuntu:latest

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates curl openssl sudo bash xvfb x11vnc xfce4 faenza-icon-theme wget transmission-remote-gtk openssh-client

ENV DISPLAY :5
ENV RESOLUTION 1920x1080x24
ENV VNC_PASSWORD pleasechange
ENV VNC_PORT 5900
ENV V_USER xfce4
ENV V_UID 1010
ENV V_GID 1010

EXPOSE $VNC_PORT

RUN addgroup --gid $V_GID $V_USER
RUN adduser --home /home/$V_USER --shell /bin/bash --system --disabled-password --uid $V_UID --gid $V_GID $V_USER && \
    echo '$V_USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm -f ./google-chrome-stable_current_amd64.deb

COPY entry.sh /entry.sh

RUN apt clean -y

USER $V_USER
WORKDIR /home/$V_USER

CMD [ "/bin/bash", "/entry.sh" ]
