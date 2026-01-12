#!/bin/bash



if [ -d /host ] 
then 
  echo source /usr/share/bash-completion/bash_completion >> /root/.bash_aliases
  source /root/.bash_aliases

  for i in crictl kubectl helm 
  do 
    (command $i > /dev/null) && ( $i completion bash > /etc/bash_completion.d/${i}_completion ) 
  done
  
else
  echo "no /host dir found"
fi

cd /notebooks

JUPYTERLAB_PORT="${JUPYTERLAB_PORT:-8888}"
JUPYTERLAB_LOGLEVEL="${JUPYTERLAB_LOGLEVEL:-INFO}" 
JUPYTERLAB_WELCOME="${JUPYTERLAB_WELCOME:-/notebooks/Welcome.ipynb}"

/usr/local/bin/jupyter-lab --allow-root --port=$JUPYTERLAB_PORT --log-level=$JUPYTERLAB_LOGLEVEL $JUPYTERLAB_WELCOME --IdentityProvider.token=$JUPYTERLAB_TOKEN

