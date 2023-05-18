#! /bin/bash

echo "This script is a bootstrap script that will install the following:"
echo "\t'Python'"
echo "\t'Ansible'\n"

CURRENT_DIR=$(pwd)
PYTHON_VERSION="3.11.3"
PYTHON_SOURCE_URL="https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz"
PYTHON_INSTALL_DIR="/opt/python/$PYTHON_VERSION"

install_dependencies() {
    apt update
    apt -y install build-essential libffi-dev libgdbm-dev \
           libsqlite3-dev libssl-dev zlib1g-dev curl
}

install_python() {
    if [ -d $PYTHON_INSTALL_DIR ]; then
        echo "Python is already installed."
        return 0
    fi

    curl -O $PYTHON_SOURCE_URL
    tar -xvzf Python-$PYTHON_VERSION.tgz
    cd Python-$PYTHON_VERSION

    ./configure \
      --prefix=$PYTHON_INSTALL_DIR \
      --enable-shared \
      --enable-optimizations \
      LDFLAGS=-Wl,-rpath=/opt/python/${PYTHON_VERSION}/lib,--disable-new-dtags
    make
    make install

    rm Python-$PYTHON_VERSION.tgz
    rm -rf Python-$PYTHON_VERSION
}

install_dependencies
install_python

"$PYTHON_INSTALL_DIR/bin/pip3" install ansible
"$PYTHON_INSTALL_DIR/bin/ansible-playbook" "$CURRENT_DIR/install-core.yml"