FROM ubuntu:latest

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates curl openssl sudo bash xvfb x11vnc xfce4 faenza-icon-theme wget transmission-remote-gtk
RUN apt install -y openssh-client

ENV DISPLAY :99
ENV RESOLUTION 1920x1080x24

RUN addgroup --gid 1000 alpine
RUN adduser --home /home/alpine --shell /bin/bash --system --disabled-password --uid 1000 --gid 1000 alpine && \
    echo 'alpine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm -f ./google-chrome-stable_current_amd64.deb

COPY entry.sh /entry.sh

RUN apt clean -y

USER alpine
WORKDIR /home/alpine

CMD [ "/bin/bash", "/entry.sh" ]
