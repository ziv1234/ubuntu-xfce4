# ubuntu-xfce4

Simple Docker image providing Xfce4 Desktop and VNC server with chrome and firefox.

#### Configuration

To set up remote X framebuffer display define resolution in docker run or docker-compose 

```sh
environment:
  - RESOLUTION=1920x1080x24
  - VNC_PASSWORD=password
```

#### Build Image

```sh
git clone https://github.com/ziv1234/ubuntu-xfce4.git
docker build -t ubuntu-xfce4 ubuntu-xfce4/
```

#### Run Image

```sh
docker run -it -p 5900:5900 --rm ubuntu-xfce4
```

#### Connect With VNC

Use `vncviewer` or similar software to connect to container. Predefined password is `pleasechange`.

#### LICENCE

MIT
