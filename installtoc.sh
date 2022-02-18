#!/bin/bash

sudo apt install -y fswatch
cd $GOBIN
wget \
https://github.com/ycd/toc/releases/download/v0.2.5/toc_0.2.5_linux_x86_64.tar.gz
tar xvf toc_0.2.5_linux_x86_64.tar.gz
chmod +rw toc_0.2.5_linux_x86_64.tar.gz
rm toc_0.2.5_linux_x86_64.tar.gz
