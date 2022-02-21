# Installation

- [Installation](#installation)
	- [Ubuntu Linux](#ubuntu-linux)
		- [Downloading](#downloading)
		- [Unpack the archive](#unpack-the-archive)
		- [Set up environment variables](#set-up-environment-variables)

## Ubuntu Linux

This more or less includes Debian, Mint and Pop OS, and other versions that 
use debian packages. 

There is versions of Go available in the repositories for these versions of 
linux, but they are old, latest being 1.13. It is not advisable to use these.

There is some tools that one should always have on a linux system anyway, so 
go ahead and make sure they are there:

    sudo apt install -y build-essential wget curl git

### Downloading

Especially since the introduction of the `embed` directive, extremely useful 
for adding assets to a Go binary, one really wants to use at least version 1.16 

Go's API and language stability guarantees cover the major version, and so 
in general, any given piece of Go code written for version 1 will work with 
any later version, almost never it is the case that it won't compile.

The build system, however, has changed a lot since 1.11 with the 
introduction of modules, which primarily affects the `go.mod` in particular. 
After nearly 3 years since its introduction, there is no reason not to use 
modules, and they greatly improve the reproducibility of builds.

Thus, visit [https://go.dev/dl/](https://go.dev/dl/) and download the latest 
one you find at the top, as appropriate for your platform. MacOS and Windows 
platforms are a little more complicated to work with, for this document we 
will cover Linux, and focus on Ubuntu.

### Unpack the archive

The procedure here basically involves simply using tar to decompress the 
archive. The location to do this must match the environment set up in the 
following section.

    cd ~
    sudo rm -rf go # when installing a new version, you must wipe out the old
    wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
    tar xvf go1.17.7.linux-amd64.tar.gz

If you want to install a different version

### Set up environment variables

Add the following to your `~/.bashrc` or `~/.zshrc`:

    export GOBIN=$HOME/bin
    export GOPATH=$HOME
    export GOROOT=$GOPATH/go
    export PATH=$HOME/go/bin:$HOME/.local/bin:$GOBIN:$PATH
