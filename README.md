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


## Installation -- Build and Run

Run the `build` script creating a local container image tagged `training-minikube` 
and use `start`, which boots into the docker vm-driver 
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
