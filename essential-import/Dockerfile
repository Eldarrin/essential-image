FROM registry.access.redhat.com/ubi9-minimal:9.3-1612 as builder

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64

RUN microdnf -y install java-1.8.0-openjdk-devel unzip net-tools hostname tar && \
    microdnf clean all

RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz && \
    tar -xvf apache-tomcat-9.0.87.tar.gz && \
    mv apache-tomcat-9.0.87 /usr/local/tomcat && \
    rm apache-tomcat-9.0.87.tar.gz

RUN curl -O https://essential-cdn.s3-eu-west-2.amazonaws.com/import-utility/essential_import_utility_291.war && \
    mv essential_import_utility_291.war /usr/local/tomcat/webapps/essential_import_utility.war

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
