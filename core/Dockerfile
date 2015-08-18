FROM centos:latest
MAINTAINER Benedikt von St. Vieth

# install dependencies and clean-up afterwards
RUN yum -y update && yum install -y wget java-1.8.0-openjdk-headless && yum clean all && rm -rf /var/lib/{rpm,yum}

RUN wget -q -O '/unicore.tgz' 'https://swift.zam.kfa-juelich.de:8889/v1/AUTH_acf10a23f9af48ec961c5354888cc212/public/unicore-servers-7.4.0.tgz' && \
    mkdir '/opt/unicore' && \
    tar -xzf /unicore.tgz -C /opt/unicore --strip-components 1 && \
    rm -rf /unicore.tgz /opt/unicore/docs && \
    cd /opt/unicore && \
    sed -i 's/gwHost=hostname/gwHost=0.0.0.0/' configure.properties && \
    sed -i 's/registry=false/registry=true/' configure.properties && \
    sed -i 's/tsi=true/tsi=false/' configure.properties && \
    sed -i 's/uxGatewayHost=${gwHost}/uxGatewayHost=WSRFLITEURL/' configure.properties && \
    sed -i 's/registryGatewayHost=${gwHost}/registryGatewayHost=WSRFLITEURL/' configure.properties


ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# default gateway port
EXPOSE 8080

# it is not required because we are in the container context, but maybe we will use it somewhen
#RUN useradd -s /bin/nologin unicore && chown -R unicore:unicore /opt/unicore
#USER unicore