# training-minikube

This project contains a files to extend the original container image with Jupyter notebooks, 
including a `bash` kernel, Systemd service file and a Go development environment.

# Goals

The intended use is for trainings, where Minikube is running a Kubernetes environment 
inside a container using Jupyter notebooks as lessons. Go has been added to build 
tools and applications for Kubernetes, like `kube-bench` on the fly.

## Requirements

The image and the scripts have been tested using 

* Ubuntu 20.4
* Docker Community 19.03.12
* derived from Minikube version v1.16.0

## Build and Run

Run the `build` script creating a local container image tagged `training-minikube` 
and use `start`, which boots into the docker vm-driver and shows the url to access the Jupyter notebooks.

```
😄  minikube v1.16.0 auf Ubuntu 20.04
✨  Using the docker driver based on user configuration
❗  docker is currently using the aufs storage driver, consider switching to overlay2 for better performance
👍  Starting control plane node minikube in cluster minikube
🔥  Creating docker container (CPUs=4, Memory=8192MB) ...
🐳  Vorbereiten von Kubernetes v1.20.0 auf Docker 20.10.2...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
open the URI  

		http://192.168.49.2:8888/lab?token=e588aab6764598f9652dbbd34588fea994a64f6c9c4d29bf

to connect to Jupyterlab in Minikube

```

## Mounting the home directory

The users home directory is mounted into the container to persist the edited notebooks.
