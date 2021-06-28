sudo chown coder /home/coder
sudo chown coder /home/coder/workspace
dumb-init fixuid -q /usr/bin/code-server --bind-addr 0.0.0.0:8080 .
