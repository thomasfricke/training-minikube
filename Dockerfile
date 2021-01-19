FROM gcr.io/k8s-minikube/kicbase:v0.0.15-snapshot4@sha256:ef1f485b5a1cfa4c989bc05e153f0a8525968ec999e242efff871cbb31649c16
RUN apt-get update && apt-get upgrade -y && apt install -y  python3-pip wget lsof openssl vim git
RUN pip3 install jupyterlab bash_kernel && python3 -m bash_kernel.install
ADD https://golang.org/dl/go1.15.6.linux-amd64.tar.gz /tmp
RUN tar  xf /tmp/go*tar.gz  -C /usr/local
RUN mkdir -p /root/.kube && ln -s /var/lib/minikube/kubeconfig /root/.kube/config
COPY jupyter.service /etc/systemd/system/jupyter.service
RUN ln -s /etc/systemd/system/jupyter.service /etc/systemd/system/default.target.wants/jupyter.service 
RUN sed -i s+/snap/bin+/usr/local/go/bin:/root/go/bin:/home/docker/go/bin:/var/lib/minikube/binaries/v1.20.0+ /etc/environment
COPY showurl /usr/local/bin

