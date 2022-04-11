#!/bin/bash

if [ -d /host ] 
then 
  for i in $(find  /host/run -type s | grep -v containerd/s | grep -v systemd)
  do
    dir=$(dirname $i | sed 's+^/host++')
    mkdir -p $dir
    ln -s $i  $dir
  done
else
  echo "no /host dir found"
fi

/usr/local/bin/jupyter-lab --ip $(hostname -i) --allow-root --log-level=INFO
