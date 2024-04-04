FROM registry.access.redhat.com/ubi9-minimal:9.3-1612 as builder

RUN microdnf -y install java-1.8.0-openjdk unzip net-tools hostname tar && \
    microdnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64

RUN curl -O https://essential-cdn.s3.eu-west-2.amazonaws.com/protege/install_protege_3.5-Linux64-noJVM.bin && \
    sh install_protege_3.5-Linux64-noJVM.bin -i silent && \
    rm install_protege_3.5-Linux64-noJVM.bin

RUN mkdir -p /Essential/Repository/ && \
    curl -O https://essential-cdn.s3-eu-west-2.amazonaws.com/meta-model/essential_baseline_v6_19.zip && \
    mv essential_baseline_v6_19.zip /Essential/Repository/ && \
    unzip /Essential/Repository/essential_baseline_v6_19.zip -d /Essential/Repository/ && \
    rm /Essential/Repository/essential_baseline_v6_19.zip

RUN curl -O https://cdn.mysql.com/archives/mysql-connector-java-8.2/mysql-connector-j-8.2.0.tar.gz && \
    tar xvf mysql-connector-j-8.2.0.tar.gz && \
    mv mysql-connector-j-8.2.0/mysql-connector-j-8.2.0.jar /root/Protege_3.5/driver.jar

COPY server/ /root/Protege_3.5/examples/server/
COPY auto-install.xml .

RUN curl -O https://essential-cdn.s3.eu-west-2.amazonaws.com/essential-widgets/essentialinstallupgrade67.jar && \
    /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64/jre/bin/java -jar essentialinstallupgrade67.jar auto-install.xml && \
    rm essentialinstallupgrade67.jar auto-install.xml

RUN echo "ui.sort.class.tree=false" >> /root/Protege_3.5/protege.properties
RUN echo "Database.type.varchar.maxsize.com.mysql.jdbc.Driver=255" >> /root/Protege_3.5/protege.properties
RUN echo "Database.typename.short.value.type.com.mysql.jdbc.Driver=VARCHAR(255)" >> /root/Protege_3.5/protege.properties

RUN echo "edu.stanford.smi.protege.storage.database.DatabaseKnowledgeBaseSourcesEditor.driver=com.mysql.cj.jdbc.Driver" >> /root/Protege_3.5/protege.properties
RUN echo "edu.stanford.smi.protege.storage.database.DatabaseKnowledgeBaseSourcesEditor.table=ProjectStore" >> /root/Protege_3.5/protege.properties
RUN echo "edu.stanford.smi.protege.storage.database.DatabaseKnowledgeBaseSourcesEditor.username=root" >> /root/Protege_3.5/protege.properties
RUN echo "edu.stanford.smi.protege.storage.database.DatabaseKnowledgeBaseSourcesEditor.url=jdbc\:mysql\://flibble\:30500/essential" >> /root/Protege_3.5/protege.properties

RUN sed -i 's/lax.nl.java.option.java.heap.size.max=524288000/lax.nl.java.option.java.heap.size.max=2048000000/' /root/Protege_3.5/Protege.lax

#
#    Go to File -> Preferences and go to the ‘protege.properties’
#    Create a new property called: Database.type.varchar.maxsize.com.mysql.jdbc.Driver and set the value to 255
#    Create another new property called: Database.typename.short.value.type.com.mysql.jdbc.Driver and set that value to VARCHAR(255)
#


COPY startup.sh .
RUN chmod +x startup.sh

CMD ["/startup.sh"]



