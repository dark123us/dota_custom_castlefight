FROM python

ENV LANG C.UTF-8
ENV TZ=Europe/Minsk
ENV DEBIAN_FRONTEND=noninteractive

# && export DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y mc tmux htop xclip sudo wget curl \
    vim bash-completion git apt-utils software-properties-common \
    inotify-tools

RUN apt install -y python3-sphinx



