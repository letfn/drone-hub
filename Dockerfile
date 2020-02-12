FROM letfn/container AS download

USER root

RUN curl -sSL -O https://github.com/github/hub/releases/download/v2.14.1/hub-linux-amd64-2.14.1.tgz \
  && tar xfz hub-linux-amd64-2.14.1.tgz \
  && rm -f hub-linux-amd64-2.14.1.tgz \
  && chmod 755 hub-linux-amd64-2.14.1/bin/hub \
  && mv hub-linux-amd64-2.14.1/bin/hub /usr/local/bin/ \
  && rm -rf hub-linux-amd64-2.14.1

FROM letfn/container

WORKDIR /drone/src

USER root
RUN apk update

COPY --from=download /usr/local/bin/hub /usr/local/bin/hub

COPY plugin /plugin

USER app

ENTRYPOINT [ "/plugin" ]
