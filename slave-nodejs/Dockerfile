FROM csanchez/jenkins-swarm-slave

USER root

RUN set -x && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y \
        nodejs build-essential

USER jenkins-slave