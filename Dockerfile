FROM  gcr.io/k8s-minikube/kicbase:v0.0.48

ENV TZ="Europe/Berlin"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install tooling
# at the moment the Suse cert chain is broken, preinstalled anyway
#
# RUN rm /etc/apt/sources.list.d/devel\:kubic\:libcontainers\:stable\:cri-o\:1.22.list

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python3-pip curl wget lsof openssl vim git bash-completion jq pandoc graphviz

RUN pip3 install jupyterlab bash_kernel \
    && python3 -m bash_kernel.install

# add golang
RUN curl -L https://go.dev/dl/go1.25.5.linux-amd64.tar.gz  | tar -zxf - -C /usr/local

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN apt-get update && apt-get install -y apt-transport-https 

ADD notebooks /notebooks
ADD jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py

ADD entrypoint.sh /entrypoint.sh

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/bin



ENTRYPOINT ["/entrypoint.sh"]

