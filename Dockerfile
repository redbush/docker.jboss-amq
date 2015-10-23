FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>

### Set Environment
ENV AMQ_VERSION 6.2.0
ENV AMQ_BUILD redhat-133

ENV AMQ_HOME /opt/jboss/jboss-a-mq-$AMQ_VERSION

### Install AMQ
ADD install_files/jboss-a-mq-$AMQ_VERSION.$AMQ_BUILD.zip /tmp/jboss-a-mq-$AMQ_VERSION.zip
RUN unzip /tmp/jboss-a-mq-$AMQ_VERSION.zip
ADD init.sh /opt/jboss/jboss-a-mq-$AMQ_VERSION/init.sh

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $AMQ_HOME/etc/users.properties && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT $AMQ_HOME/docker_init.sh
