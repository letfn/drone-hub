FROM letfn/container

WORKDIR /drone/src

RUN echo 1

RUN apt-get update && apt-get upgrade -y

RUN curl -sSL -O https://github.com/github/hub/releases/download/v2.14.1/hub-linux-amd64-2.14.1.tgz \
  && tar xfz hub-linux-amd64-2.14.1.tgz \
  && rm -f hub-linux-amd64-2.14.1.tgz \
  && chmod 755 hub-linux-amd64-2.14.1/bin/hub \
  && mv hub-linux-amd64-2.14.1/bin/hub /usr/local/bin/ \
  && rm -rf hub-linux-amd64-2.14.1

COPY plugin /plugin

ENTRYPOINT [ "/plugin" ]
