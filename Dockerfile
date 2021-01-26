FROM gcr.io/k8s-minikube/kicbase:v0.0.17

# install tooling
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python3-pip wget lsof openssl vim git bash-completion jq

RUN pip3 install jupyterlab bash_kernel \
    && python3 -m bash_kernel.install

# add golang
RUN curl -L /tmp/go.tar.gz https://golang.org/dl/go1.15.6.linux-amd64.tar.gz | tar -zxf - -C /usr/local

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# fix paths
RUN sed -i s+/snap/bin+/usr/local/go/bin:/root/go/bin:/home/docker/go/bin:/var/lib/minikube/binaries/v1.20.2+ /etc/environment

# add files
ADD fsroot/ /
