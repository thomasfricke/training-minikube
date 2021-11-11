FROM gcr.io/k8s-minikube/kicbase:v0.0.27

# install tooling

RUN rm /etc/apt/sources.list.d/devel\:kubic\:libcontainers\:stable\:cri-o\:1.22.list

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install -y python3-pip wget lsof openssl vim git bash-completion jq pandoc

RUN pip3 install jupyterlab bash_kernel \
    && python3 -m bash_kernel.install

# add golang
RUN curl -L /tmp/go.tar.gz https://golang.org/dl/go1.16.5.linux-amd64.tar.gz | tar -zxf - -C /usr/local

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# fix paths
RUN sed -i s+/snap/bin+/usr/local/go/bin:/root/go/bin:/home/docker/go/bin:/var/lib/minikube/binaries/v1.20.0+ /etc/environment

RUN apt-get update && sudo apt-get install -y apt-transport-https \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
    && sudo apt-get update \
    && sudo apt-get install -y kubectl

#RUN wget -q https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/1.22/xUbuntu_20.04/amd64/cri-o_1.22.0~0_amd64.deb \
#    && dpkg -i cri-o_1.22.0~0_amd64.deb \
#    && rm cri-o_1.22.0~0_amd64.deb

# add files
ADD fsroot/ /


