#!/bin/bash

# Set the path to the directory where the Protege server is installed
cd /root/Protege_3.5

CODEBASE_URL=file:$PWD/protege.jar
CODEBASE=-Djava.rmi.server.codebase=$CODEBASE_URL

if [ -z "$HOST_URL" ]; then
    HOST_URL=`hostname`
fi

HOSTNAME_PARAM=-Djava.rmi.server.hostname=$HOST_URL

/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64/jre/bin/rmiregistry 31100 -J$CODEBASE &
/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-2.el9.x86_64/jre/bin/java -Xms250M -Xmx2048M -cp protege.jar:looks-2.1.3.jar:unicode_panel.jar \
    $HOSTNAME_PARAM -Dtransaction.level=READ_COMMITTED -Djava.awt.headless=true \
    -Dprotege.rmi.server.port=31200 -Dprotege.rmi.registry.port=31100 \
    -Djava.rmi.server.codebase=file:/home/rwf/protege_3.5/protege.jar edu.stanford.smi.protege.server.Server examples/server/metaproject.pprj
