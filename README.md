# unicore-dockerfiles
This repository holds a Dockerfile to create a simplistic one-container [UNICORE](https://www.unicore.eu/) core server deployment.

It is linked to the [Docker Hub](https://hub.docker.com/r/benedicere/unicore/) to provide automated builds on new UNICORE versions.

You can spin up a container by issuing
```docker run -p 8080:8080 -e WSRFLITEURL=<hostname> benedicere/unicore```
or
```docker run -d -p 8082:8082 -e WSRFLITEURL=<hostname> -e GATEWAYPORT=8082 benedicere/unicore```

