FROM ubuntu 

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
RUN curl -L /tmp/go.tar.gz https://go.dev/dl/go1.18.linux-amd64.tar.gz  | tar -zxf - -C /usr/local

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# fix paths
RUN sed -i s+/snap/bin+/usr/local/go/bin:/root/go/bin:/home/docker/go/bin:/var/lib/minikube/binaries/v1.20.0+ /etc/environment

RUN apt-get update && apt-get install -y apt-transport-https \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl \
    && curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

ADD entrypoint.sh /usr/local/bin
ADD notebooks /notebooks

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

