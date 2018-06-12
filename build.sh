#!/bin/bash

readonly DIR="$(realpath $(dirname ${BASH_SOURCE[0]}))"
readonly REPOSITORY="mdelapenya"
readonly IMAGE_NAME_PREFIX="jenkins-slave"

build() {
    local dir=$1
    local image=$2
    local tag=$3

    cd ${DIR}/${dir}
    docker build -t ${image}:${tag} .
}

build_master() {
    build master ${REPOSITORY}/jenkins "1.0.0"
}

build_slave() {
    local nodeType=$1

    build slave-${nodeType} ${REPOSITORY}/${IMAGE_NAME_PREFIX}-${nodeType} "1.0.0"
}

build_wedeploy_node() {
    build wedeploy-node ${REPOSITORY}/dind-slave "1.0.0"
}

build_nodes() {
    build_wedeploy_node

    build_master
    build_slave golang
    build_slave java
    build_slave nodejs
}

update_nodes() {
    docker service update --force jenkins_golang --image ${REPOSITORY}/${IMAGE_NAME_PREFIX}-golang:1.0.0
    docker service update --force jenkins_java --image ${REPOSITORY}/${IMAGE_NAME_PREFIX}-java:1.0.0
    docker service update --force jenkins_nodejs --image ${REPOSITORY}/${IMAGE_NAME_PREFIX}-nodejs:1.0.0
}

main() {
    local action=$1

    case ${action} in
        compose-down)
            docker-compose down
        ;;

        compose-up)
            docker-compose up
        ;;

        build)
            build_nodes
        ;;

        stack-deploy)
            docker stack deploy --compose-file="$(pwd)/docker-swarm/stack.yml" jenkins
        ;;

        stack-rm)
            docker stack rm jenkins
        ;;

        stack-update)
            update_nodes
        ;;

        *)
            echo "Execute this script with:
            - [build] build all the images, or
            - [compose-up|compose-down] for a Docker compose-style deployment, or
            - [stack-deploy|stack-rm|stack-update] for a Docker Swarm one"
        ;;
    esac
}

main "$@"