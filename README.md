# training-minikube

This project contains files to extend the original container image with Jupyter notebooks, 
including a `bash` kernel, Systemd service file and a Go development environment.

Minikube is the testbed to test Kubernetes, Jupyter is the standard for using notebooks 
running complex scenarios.

# Goals

The intended use is for trainings, where Minikube is running a Kubernetes environment 
inside a container using Jupyter notebooks as lessons. Go has been added to build 
tools and applications for Kubernetes, like `kube-bench` on the fly using `go get ...`.

## Requirements

The image and the scripts have been tested using 

* Ubuntu 20.4
* Docker Community 19.03.12
* derived from Minikube version v1.16.0
* Go version go1.15.6

Other operating systems should work, but have not been tested. 
Inside the container another Docker runtime is used to run Kubernetes pods. 
Cri-o and containerd should work and can be tested as far as Minikube is supporting them.

## Installation

### Setup environment

0. Make free space available

Make sure you've got at least 5 GiB free space available.

1. Install minikube

  Follow https://minikube.sigs.k8s.io/docs/start/ for the mainstream linux
  distributions. To install it on Arch Linux run `pacman -S minikube`.

2. Fix permissions to run `minikube` with `docker`-driver:

   ~~~
   sudo usermod -aG docker $USER && newgrp docker
   ~~~

### Modify environment

**Fedora 33**

Please make sure you run your kernel with cgroups v1. Using cgroups v2 will break the `build`-script. 


Please pass `systemd.unified_cgroup_hierarchy=0` to the kernel for newer Fedoras >= 31 in `/etc/sysconfig/grub` ([Red Hat](https://www.redhat.com/sysadmin/fedora-31-control-group-v2)) to disable cgroups v1.

Configure SELinux via `/etc/selinux/config` to be permissive.

~~~
SELINUX=permissive
~~~

Remove the corresponding setting for the docker daemon in `/etc/sysconfig/docker`.

~~~
# OPTIONS="--selinux-enabled
OPTIONS="
  --log-driver=journald \
  --storage-driver=overlay2 \
  --live-restore \
  --default-ulimit nofile=1024:1024 \
  --init-path /usr/libexec/docker/docker-init \
  --userland-proxy-path /usr/libexec/docker/docker-proxy \
"
~~~

### Build and Run image

Run the `bin/build` script creating a local container image tagged `training-minikube` 
and use `bin/start`, which boots into the docker vm-driver 
and shows the url to access the Jupyter notebooks.

```
😄  minikube v1.16.0 auf Ubuntu 20.04
✨  Using the docker driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🔥  Creating docker container (CPUs=4, Memory=8192MB) ...
🐳  Preparing Kubernetes v1.20.0 auf Docker 20.10.2...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
open the URI  

    http://192.168.49.2:8888/lab?token=e5...bf

to connect to Jupyterlab in Minikube

```

## Mounting the home directory

The users home directory is mounted into the container to persist the edited notebooks.
