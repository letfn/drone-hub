FROM letfn/container AS download

ARG _HUB_VERSION=2.14.1
ARG _GH_VERSION=0.5.5

WORKDIR /tmp

RUN curl -sSL -O https://github.com/github/hub/releases/download/v${_HUB_VERSION}/hub-linux-amd64-${_HUB_VERSION}.tgz \
  && tar xfz hub-linux-amd64-${_HUB_VERSION}.tgz \
  && mv hub-linux-amd64-${_HUB_VERSION}/bin/hub hub \
  && chmod 755 hub

RUN curl -sSL -O https://github.com/cli/cli/releases/download/v${_GH_VERSION}/gh_${_GH_VERSION}_linux_amd64.tar.gz \
  && tar xvfz gh_${_GH_VERSION}_linux_amd64.tar.gz \
  && chmod 755 gh_${_GH_VERSION}_linux_amd64/bin/gh \
  && mv gh_${_GH_VERSION}_linux_amd64/bin/gh gh \
  && chmod 755 gh

FROM letfn/python

COPY --from=download /tmp/hub /usr/local/bin/hub
COPY --from=download /tmp/gh /usr/local/bin/gh

USER root
RUN apt-get update && apt-get install -y git
USER app

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
