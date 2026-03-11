# training-minikube

This project contains files to extend the original container image with Jupyter notebooks, 
including a `bash` kernel, Systemd service file and a Go development environment.

Minikube is the testbed to test Kubernetes, Jupyter is the standard for using notebooks 
running complex scenarios.

# Goals

The intended use is for trainings, where this image is run in a privileged container.

## k3s

Apply the secret to login first

```bash
kubectl create -f secret-training.yaml
```

You can obtain the token to login with

```bash
kubectl get secret training -o jsonpath='{.data.token}' | base64 --decode
```

Finally run the very privileged container on the first host

```bash
kubectl create -f k3s-training.yaml
```

## Access

The container is deployed on host `k3d-host-cluster-server-0`.
Adapt if your cluster has different names. You can now open
`http://k3d-host-cluster-server-0:8889/lab` in a browser. 

Change the name of the URI according to your setup. If you
run k3s on the same node as the browser just use
`http://localhost:8889/lab`

The port can be configured in the `k3s-training.yaml`.
Just change `JUPYTERLAB_PORT` to your needs.


## Dockerfile

You can bake your own images and add additional tools. This might be useful
especially for air gapped environments.

If your pod has internet access you can additionally add tools add runtime
from inside

## Have fun!

Enjoy and give feedback! Especially if you make this run on different kinds
of Kubernetes
