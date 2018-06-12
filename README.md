# Jenkins stack

This project represents a Jenkins stack with different build node types: one for `golang` projects, other for `java` projects, and another for `nodejs` ones.

## Jenkins Docker-in-Docker slaves

There is a [wedeploy-node](./wedeploy-node) directory with the base slave node, which is an aggregation of [the official Docker DinD image](https://github.com/docker-library/docker/tree/master/18.05/dind), plus [Carlos Sanchez's work](https://github.com/carlossg/jenkins-swarm-slave-docker) for a Jenkins slave that self-joins to a Jenkins swarm.

## Testing the stack

Please first use the [build.sh](./build.sh) script to build the images:

### docker-compose

Please use the [build.sh](./build.sh) script:

```shell
$ ./build.sh build # builds the images
```

### Docker Swarm

It's not possible to test this stack in Docker Swarm because `--privileged` is not supported. But if you still want to execute the stack in a Swarm, please use the [build.sh](./build.sh) script:

```shell
$ ./build.sh stack-deploy # starts the swarm stack

$ ./build.sh stack-rm # shuts down the swarm stack

$ ./build.sh stack-update # updates the swarm stack if any image is changed
```

## License

[BSD-3-Clause](./LICENSE.md), © Liferay, Inc.
