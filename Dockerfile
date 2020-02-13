FROM letfn/container AS download

USER root

RUN curl -sSL -O https://github.com/github/hub/releases/download/v2.14.1/hub-linux-amd64-2.14.1.tgz \
  && tar xfz hub-linux-amd64-2.14.1.tgz \
  && rm -f hub-linux-amd64-2.14.1.tgz \
  && chmod 755 hub-linux-amd64-2.14.1/bin/hub \
  && mv hub-linux-amd64-2.14.1/bin/hub /usr/local/bin/ \
  && rm -rf hub-linux-amd64-2.14.1

RUN curl -sSL -O https://github.com/cli/cli/releases/download/v0.5.4/gh_0.5.4_linux_amd64.tar.gz \
  && tar xvfz gh_0.5.4_linux_amd64.tar.gz \
  && rm -f gh_0.5.4_linux_amd64.tar.gz \
  && chmod 755 gh_0.5.4_linux_amd64/bin/gh \
  && mv gh_0.5.4_linux_amd64/bin/gh /usr/local/bin/ \
  && rm -rf gh_0.5.4_linux_amd64

FROM letfn/python

COPY --from=download /usr/local/bin/hub /usr/local/bin/hub
COPY --from=download /usr/local/bin/gh /usr/local/bin/gh

USER root
RUN apt-get update && apt-get install -y git
USER app

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
