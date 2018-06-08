FROM csanchez/jenkins-swarm-slave

USER root

RUN set -x && \
    curl -O https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz && \
    tar -xvf go1.9.1.linux-amd64.tar.gz && \
    mv go /usr/local

ENV PATH=$PATH:/usr/local/go/bin

USER jenkins-slave