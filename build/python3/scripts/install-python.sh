# install-python.sh
# Script to install Python 2 and 3 in a Singularity container

download_and_install() {
	cd $WORKDIR
	wget https://www.python.org/ftp/python/$1/Python-$1.tgz
	gunzip Python-$1.tgz && tar -xvf Python-$1.tar
	cd Python-$1
	./configure -prefix=/usr/local
	make
	make install
}

if [ "$#" -ne 3 ]; then
    printf "Usage: install-python <Python 2 version> <Python 3 version> <working directory>\n\n"
    exit 1
fi

PY2VER=$1
PY3VER=$2
WORKDIR=$3

# Install packages required for pip installation
# Note: Following line solves SSL module error. See SO question #41328451
apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
		libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev zlib1g-dev \
		libffi-dev 

# Install Python 3
download_and_install $PY3VER
ln -sfn /usr/local/bin/python3.7 /usr/bin/python3
	
# Install Python 2
download_and_install $PY2VER
ln -sfn /usr/local/bin/python2.7 /usr/bin/python2.7
	
# Install pip3
# Note: Following 2 lines solve lsb_release error. See SO question #44967202
sed -i '1d' /usr/bin/lsb_release
sed -i '1i#!/usr/bin/python\n' /usr/bin/lsb_release
pip3 install --upgrade pip
