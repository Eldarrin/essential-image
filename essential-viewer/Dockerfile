FROM registry.access.redhat.com/ubi9-minimal:9.3-1612 as builder

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64

RUN microdnf -y install java-1.8.0-openjdk-devel unzip net-tools hostname tar && \
    microdnf clean all

RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz && \
    tar -xvf apache-tomcat-9.0.87.tar.gz && \
    mv apache-tomcat-9.0.87 /usr/local/tomcat && \
    rm apache-tomcat-9.0.87.tar.gz && \
    curl -O https://github.com/essentialproject/essential_viewer/releases/download/6.19.2/essential_viewer_6192.war && \
    mv essential_viewer_6192.war /usr/local/tomcat/webapps/essential_viewer.war

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
