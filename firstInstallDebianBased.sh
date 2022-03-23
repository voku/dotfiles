#!/usr/bin/env bash

# use the bash as default "sh", fixed some problems
# with e.g. third-party scripts
#sudo ln -sf /bin/bash /bin/sh

function ask_install() {
  echo
  echo
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi

}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
  exit 1
fi

# use aptitude in the next steps ...
if [ \! -f $(whereis aptitude | cut -f 2 -d ' ') ] ; then
  apt-get install aptitude
fi

# update && upgrade
ask_install "upgrade your system?"
if [[ $? -eq 1 ]]; then
  aptitude update
  aptitude upgrade
fi

aptitude install \
  `# read-write NTFS driver for Linux` \
  ntfs-3g \
  `# do not delete main-system-dirs` \
  safe-rm \
  `# default for many other things` \
  tmux \
  build-essential \
  autoconf \
  make \
  cmake \
  dialog \
  `# unzip, unrar etc.` \
  cabextract \
  zip \
  unzip \
  rar \
  unrar \
  tar \
  pigz \
  p7zip \
  p7zip-full \
  p7zip-rar \
  unace \
  bzip2 \
  gzip \
  xz-utils \
  advancecomp \
  `# optimize image-size` \
  gifsicle \
  optipng \
  pngcrush \
  pngnq \
  pngquant \
  jpegoptim \
  libjpeg-progs \
  jhead \
  `# utilities` \
  coreutils  \
  findutils  \
  net-tools \
  `# fast alternative to dpkg -L and dpkg -S` \
  dlocate \
  `# quickly find files on the filesystem based on their name` \
  mlocate \
  locales \
  `# removing unneeded localizations` \
  localepurge \
  sysstat \
  tcpdump \
  colordiff \
  moreutils \
  atop \
  ack-grep \
  ngrep \
  `# interactive processes viewer` \
  htop \
  `# mysql processes viewer` \
  mytop \
  `# interactive I/O viewer` \
  iotop \
  tree \
  `# disk usage viewer` \
  ncdu \
  rsync \
  whois \
  vim \
  csstidy \
  recode \
  exuberant-ctags \
  `# GNU bash` \
  bash \
  bash-completion \
  `# command line clipboard` \
  xclip \
  `# more colors in the shell` \
  grc \
  `# fonts also "non-free"-fonts` \
  `# -- you need "multiverse" || "non-free" sources in your "source.list" -- ` \
  fontconfig \
  ttf-mscorefonts-installer \
  ttf-bitstream-vera \
  xfonts-jmk \
  `# trace everything` \
  strace \
  `# get files from web` \
  wget \
  curl \
  w3m \
  `# repo-tools`\
  git \
  subversion \
  mercurial \
  `# usefull tools` \
  nodejs \
  npm \
  ruby-full \
  imagemagick \
  lynx \
  nmap \
  pv \
  ucspi-tcp \
  xpdf \
  sqlite3 \
  perl \
  python \
  python-dev \
  python3-pip \
  `# install python-pygments for json print` \
  python3-pygments

# try zsh?
read -p "Do you want to use the zsh-shell? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  sudo aptitude install zsh
  chsh -s $(which zsh)
fi

#
# install java
#

#su -
#echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d
#echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
#aptitude update
#aptitude install oracle-java7-installer
#exit


#
# install new git / ubuntu
#

#sudo add-apt-repository -y ppa:git-core/ppa
#sudo aptitude update
#sudo aptitude upgrade git

#
# install new git / debian
#

#su -
#echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" | tee /etc/apt/sources.list.d/git-core.list
#echo "deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" | tee -a /etc/apt/sources.d/git-core.list
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24
#aptitude update
#aptitude upgrade git
#exit


#
# install Sublime Text 3
#

#sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
#sudo aptitude update
#sudo aptitude install sublime-text-installer
#sudo ln -sf /opt/sublime_text/sublime_text /usr/local/bin/sublime


#
# install node.js without deb-files e.g. for Debian - stable
#

#curl https://www.npmjs.org/install.sh | sudo sh


#
# for webworker
#

ask_install "install webworker tools"
if [[ $? -eq 1 ]]; then

  echo "update/install ruby-rems ..."

  aptitude install ruby ruby-dev

  gem update

  gem install sass
  gem install compass
  gem install autoprefixer-rails
  gem install compass-rgbapng
  gem install oily_png

  echo "update/install npm-packages ..."

  npm config set strict-ssl false
  npm config set registry http://registry.npmjs.org

  npm install -g npm

  npm update -g

  npm install -g diff-so-fancy
  npm install -g bower
  npm install -g grunt-cli
  npm install -g grunt-init
  npm install -g yo
  npm install -g svgo

  echo "install php ..."

  aptitude install php php-cli php-bcmath php-dom php-curl php-gd php-intl php-imagick php-imap php-mbstring php-memcached php-mysqli php-mailparse php-json php-intl php-ftp php-readline php-snmp php-tidy php-xml php-xsl php-xdebug php-apcu php-zip

  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
  ln -s /usr/bin/composer.phar /usr/bin/composer
fi

# clean downloaded and already installed packages
aptitude -v clean

# update-fonts
cp -vr $( dirname "${BASH_SOURCE[0]}" )/.fonts/* /usr/share/fonts/truetype/
dpkg-reconfigure fontconfig
fc-cache -fv

# update-locate-db
echo "update-locate-db ..."
updatedb -v

