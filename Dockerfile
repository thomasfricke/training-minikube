FROM gcr.io/k8s-minikube/kicbase:v0.0.15-snapshot4@sha256:ef1f485b5a1cfa4c989bc05e153f0a8525968ec999e242efff871cbb31649c16

# install tooling
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python3-pip wget lsof openssl vim git bash-completion

RUN pip3 install jupyterlab bash_kernel \
    && python3 -m bash_kernel.install

# add golang
ADD https://golang.org/dl/go1.15.6.linux-amd64.tar.gz /tmp
RUN tar xf /tmp/go*tar.gz  -C /usr/local

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# fix paths
RUN sed -i s+/snap/bin+/usr/local/go/bin:/root/go/bin:/home/docker/go/bin:/var/lib/minikube/binaries/v1.20.0+ /etc/environment

# add files
ADD fsroot/ /

