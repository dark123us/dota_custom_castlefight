FROM ubuntu

ENV LANG C.UTF-8
ENV TZ=Europe/Minsk
ENV DEBIAN_FRONTEND=noninteractive

# && export DEBIAN_FRONTEND=noninteractive
RUN groupadd -g 1000 dark123us && useradd -m dark123us -u 1000 -g dark123us -s /bin/bash 
RUN apt update && apt install -y mc tmux htop xclip sudo wget curl vim bash-completion git apt-utils software-properties-common

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && add-apt-repository ppa:neovim-ppa/unstable \
    && apt-get update && apt-get install -y nodejs neovim lua5.1 luarocks inotify-tools\
    && luarocks install lunatest \
    && luarocks install luacov \
    && luarocks install ldoc \
    && luarocks install luacheck \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /app

COPY .vimrc /root/
COPY .tmux.conf /root/
COPY init.vim /root/.config/nvim/
COPY .vimrc /home/dark123us/
COPY .tmux.conf /home/dark123us/
COPY init.vim /home/dark123us/.config/nvim/


RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
    && curl -fLo /root/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim +PluginInstall +PlugInstall +qall \
    # && cd ~/.vim/bundle/YouCompleteMe && ./install.py \
    && git config --global user.email "dark123us@gmail.com" && git config --global user.name "Vadzim Pryhodzich (vd-dev)" \
    && echo "HOST=$( cat /etc/hostname )" >> /root/.bashrc \
    && chown -R dark123us:dark123us /home/dark123us/ \
    && echo "dark123us ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers \
    && echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
    && npm install -g pyright \
    && nvim --headless +PlugInstall +qall 

USER dark123us

RUN cd /home/dark123us \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  \
    && vim +PluginInstall +PlugInstall +qall \
    # && cd ~/.vim/bundle/YouCompleteMe && ./install.py \
    && git config --global user.email "dark123us@gmail.com" && git config --global user.name "Vadzim Pryhodzich (vd-dev)" \
    && echo "HOST=$( cat /etc/hostname )" >> /home/dark123us/.bashrc  \
    && echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
    && nvim --headless +PlugInstall +qall \
    && echo 'SELECTED_EDITOR="/usr/bin/nvim"' > ~/.selected_editor 

USER root


