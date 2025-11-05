FROM kasmweb/ubuntu-noble-desktop:1.17.0-rolling-weekly
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Update Ubuntu and software.
RUN apt update \
    && sudo apt upgrade -y

# Устанавливаем зависимости
RUN apt install -y sudo wget gpg rsync htop mc net-tools locales apt-transport-https curl gnome-keyring && \
    echo "kasm-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/list/* && \
    sudo passwd -d kasm-user && \
    echo 'set -o history' >> $HOME/.bashrc && \
    echo 'shopt -s histappend' >> $HOME/.bashrc && \
    echo 'export HISTSIZE=10000' >> $HOME/.bashrc && \
    echo 'export HISTFILESIZE=10000' >> $HOME/.bashrc && \
    echo 'export HISTCONTROL=ignoreboth:erasedups' >> $HOME/.bashrc && \
    echo "export HISTFILE=/home/kasm-user/.bash_history" >> $HOME/.bashrc && \
    echo 'alias ll="ls -lah"' >> $HOME/.bashrc

# Устанавливаем windsurf
RUN wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > /usr/share/keyrings/windsurf-stable.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" > /etc/apt/sources.list.d/windsurf.list && \
    apt-get update && \
    apt-get install -y windsurf && \
    sleep 100 && \
    sed -i 's|^Exec=\(.*windsurf\)\(.*\)|Exec=\1 --no-sandbox --password-store=basic\2|' /usr/share/applications/windsurf.desktop && \
    sed -i 's|^Exec=\(.*windsurf\)\(.*\)|Exec=\1 --no-sandbox --password-store=basic\2|' /usr/share/applications/windsurf-url-handler.desktop && \
    mkdir -p /home/kasm-user/Desktop

RUN ln -sf /usr/share/applications/windsurf.desktop $HOME/Desktop/windsurf.desktop && \
    chmod a+x $HOME/Desktop/windsurf.desktop && \
    wget https://images.wallpaperscraft.com/image/single/mycena_mushroom_nature_1443869_3840x2400.jpg -O /usr/share/backgrounds/bg_default.png

RUN locale-gen ru_RU.UTF-8 && \
    update-locale LANG=ru_RU.UTF-8
ENV LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:ru \
    LC_ALL=ru_RU.UTF-8

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
