FROM node:7.6-slim
MAINTAINER Astrocoders (https://astrocoders.com)

ARG METEOR_USER=meteor
ARG METEOR_USER_DIR=/home/meteor

RUN apt-get update

# Install curl, bzip2 and libfontconfig (an undocumented dependency of phantomjs)
RUN apt-get install -y curl bzip2 libfontconfig

# Install build-tools
RUN apt-get install -y bcrypt make python g++

# Java is a Chimp pre-requisite because of Selenium
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update
RUN apt-get install -y google-chrome-stable libexif-dev

# Dependency: Git
RUN apt-get install -y git-core

# Dependency: xvfb (fake screen)
RUN apt-get install -y xvfb

# X11VNC
RUN apt-get install -y x11vnc
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd chimpatee ~/.vnc/passwd

# Install chimp
RUN npm install -g chimp

WORKDIR /app
ENTRYPOINT [ "/usr/local/bin/chimp" ]
