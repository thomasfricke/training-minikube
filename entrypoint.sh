#!/bin/bash

if [ -d /host ] 
then 
  for i in $(find  /host/run -type s | grep -v containerd/s | grep -v systemd)
  do
    dir=$(dirname $i | sed 's+^/host++')
    mkdir -p $dir
    ln -s $i  $dir
  done
  echo export 'PATH=$PATH:$(echo $PATH | sed s+^+/host+ |  sed "s+\:+\:/host+g"):/usr/local/go/bin' > /root/.bash_aliases 
  echo source /usr/share/bash-completion/bash_completion >> /root/.bash_aliases
  source /root/.bash_aliases

  for i in crictl kubectl helm ; do $i completion bash > /etc/bash_completion.d/$i.sh ; done

else
  echo "no /host dir found"
fi


/usr/local/bin/jupyter-lab --ip $(hostname -i) --allow-root --log-level=INFO
