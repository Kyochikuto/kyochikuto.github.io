#!/bin/sh
echo "alias ssh-proxy='ssh -v -o ServerAliveInterval=10 -o \"ProxyCommand=nc -X 5 -x 127.0.0.1:9050 %h %p\"'" | tee -a $HOME/.bashrc
exec $SHELL
