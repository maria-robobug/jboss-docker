FROM jboss/base-jdk:7
MAINTAINER Marek Goldmann <mgoldman@redhat.com>

USER root

# JBoss version
ENV JBOSS_HOME /opt/jboss/jboss-4.2.3.GA

# default port
EXPOSE 8080

# Install necessary packages
RUN yum -y install java-1.7.0-openjdk-devel

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java

COPY jboss4.zip /root/jboss4.zip

# Installs jboss
RUN 	cd $HOME && \
	yum update && \
	yum install unzip -y && \
	unzip -qo /root/jboss4.zip && \
	mkdir -p /opt/jboss && \
	mv /root/jboss-4.2.3.GA $JBOSS_HOME && \
	rm -rf jboss4.zip $JBOSS_HOME/server/all $JBOSS_HOME/server/minimal $JBOSS_HOME/docs && \
	yum clean all

COPY hello-world.war $JBOSS_HOME/server/default/deploy/hello-world.war

CMD ["/opt/jboss/jboss-4.2.3.GA/bin/run.sh", "-b", "0.0.0.0"]
