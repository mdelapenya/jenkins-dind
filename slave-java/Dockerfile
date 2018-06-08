FROM csanchez/jenkins-swarm-slave

USER root

RUN set -x && \
    curl -L -k --output oraclejdk.tar.gz -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz && \
    tar -xzf oraclejdk.tar.gz && \
    mv jdk1* /opt/jdk && \
    rm -f oraclejdk.tar.gz

ENV JAVA_HOME="/opt/jdk"
ENV PATH="$JAVA_HOME/bin:$PATH"

USER jenkins-slave