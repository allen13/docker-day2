docker day 2
------------

* container terminology
* container engines
* container runtimes
* oci compliant images
* union filesystem and overlay2
* container registry
* create a docker hub account
* build and share a container with the class


container terminology
---------------------

Great set of general terminology for containers

* [Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/)

container engines
-----------------

Typically, the container engine is responsible for:

* Handling user input
* Handling input over an API often from a Container Orchestrator
* Pulling the Container Images from the Registry Server
* Expanding decompressing and expanding the container image on disk using a Graph Driver (block, or file depending on driver)
* Preparing a container mount point, typically on copy-on-write storage (again block or file depending on driver)
* Preparing the metadata which will be passed to the container Container Runtime to start the Container correctly
* Using some defaults from the container image (ex.ArchX86)
* Using user input to override defaults in the container image (ex. CMD, ENTRYPOINT)
* Using defaults specified by the container image (ex. SECCOM rules)
* Calling the Container Runtime

List of major engines:
* [Docker](https://docs.docker.com/get-started/overview/#docker-architecture)
* [CRI-O](https://cri-o.io/)
* [Rkt](https://coreos.com/rkt/)
* [LXC](https://linuxcontainers.org/)

Links:
* [What do container engines really do?](http://crunchtools.com/so-what-does-a-container-engine-really-do-anyway/)

container runtimes
------------------

A container runtime is responsible for all the parts of running a container that isn't actually running the program itself. As we will see throughout this series, runtimes implement varying levels of features, but running a container is actually all that's required to call something a container runtime.

Links:
* [runc](https://www.docker.com/blog/runc/#:~:text=runC%20is%20a%20lightweight%2C%20portable,system%20features%20related%20to%20containers.&text=No%20dependency%20on%20the%20rest,container%20runtime%20and%20nothing%20else.)
oci compliant image
* [container runtimes](https://www.ianlewis.org/en/container-runtimes-part-1-introduction-container-r)

oci compliant images
--------------------

The Open Container Initiative Runtime Specification aims to specify the configuration, execution environment, and lifecycle of a container.

Links:
* [OCI Spec](https://github.com/opencontainers/runtime-spec/blob/master/spec.md)
* [Filesystem Bundle](https://github.com/opencontainers/runtime-spec/blob/master/bundle.md)


union filesystem and overlay2
-----------------------------

An overlay(fs) works very similarly to overhead projection sheets where you have a base sheet that displays something like a worksheet and a sheet above it where you can take your own notes. You can separate the two sheets and you still have your base sheet and your own notes (the difference between the base and your notes).

3 layers:

* Base Layer (Read Only)
* Overlay Layer (Main User View)
* Diff Layer

This is an example of copy-on-write (COW)

Copy-on-write is a strategy of sharing and copying files for maximum efficiency. If a file or directory exists in a lower layer within the image, and another layer (including the writable layer) needs read access to it, it just uses the existing file. The first time another layer needs to modify the file (when building the image or running the container), the file is copied into that layer and modified. This minimizes I/O and the size of each of the subsequent layers.

Links:
* [Union File System](https://www.terriblecode.com/blog/how-docker-images-work-union-file-systems-for-dummies/)
* [Docker Images and Layers](https://docs.docker.com/storage/storagedriver/#images-and-layers)

container registry
------------------

A registry server is essentially a fancy file server that is used to store docker repositories. Typically, the registry server is specified as a normal DNS name and optionally a port number to connect to. Much of the value in the docker ecosystem comes from the ability to push and pull repositories from registry servers.

Links:
* [Docker Registry](https://docs.docker.com/registry/)

create a docker hub account
---------------------------

Create an account on [Docker Hub](https://hub.docker.com/) so you can share your container images. Once you have created your account log in to docker hub.

    docker login

build and share a container with the class
------------------------------------------

clone this repository to your local machine. you may need to install git.

make a change in the `http hello response` section of the code to mark it as your own. This will differntiate the reponses from other classmates.

    fmt.Fprintf(w, "Hello from <me> %s!\n", target)

build the docker image

    docker build . -t <github account name>/hello-docker:v0.1.0
    # run this to see your the image you built
    docker images
    # see the oci compliant image config
    docker inspect <image name>

run your container

    docker run -it --rm -p 8080:8080 <github account name>/hello-docker:v0.1.0
    # navigate to your app. browser works too.
    curl localhost:8080

push your container to docker hub

    docker push <github account name>/hello-go-docker:v0.1.0

post your container name to the class image thread and then run someone eleses image

    docker run -it --rm -p 8080:8080 <other github account name>/docker-day2:v0.1.0
