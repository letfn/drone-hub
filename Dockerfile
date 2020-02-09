FROM letfn/container

WORKDIR /drone/src

RUN apt-get update && apt-get upgrade -y

COPY plugin /plugin

ENTRYPOINT [ "/plugin" ]
