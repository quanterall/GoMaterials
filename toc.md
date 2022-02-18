# Updating the Table of Contents

- [Updating the Table of Contents](#updating-the-table-of-contents)
	- [Ubuntu Linux](#ubuntu-linux)

## Ubuntu Linux

The following instructions only apply to Linux, but since Linux is the 
primary OS used for Go development and the other platforms are more 
complicated to work with, that should be fine for everyone. 

Ubuntu or Pop OS 20.04 (Pop OS is Ubuntu with better video hardware support) 
are reccommended at the time of writing (February 2022).

Run the provided installation script to install the Go based ToC generator, 
since you are reading this to learn Go, you will have it installed if you 
are contributing to this repository.

The script `installtoc.sh` assumes that you have a correctly configured `GOBIN`

Add the following to your `~/.bashrc` or `~/.zshrc`:

    export GOBIN=$HOME/go/bin
    export PATH=$HOME/bin:$HOME/.local/bin:$GOBIN:$PATH
    export GOROOT=$HOME/go
    export GOPATH=$HOME

