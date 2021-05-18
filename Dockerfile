FROM ubuntu:latest

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates curl openssl sudo bash xvfb x11vnc xfce4 faenza-icon-theme wget transmission-remote-gtk
RUN apt install -y openssh-client

ENV DISPLAY :99
ENV RESOLUTION 1920x1080x24
ENV VNC_PASSWORD alpine
ENV V_USER alpine
ENV V_UID 1000
ENV V_GID 1000

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
