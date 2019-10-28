##
## ulmer/ansible-engine-container
##

## Build Container
FROM python:3.8.0 AS buildenv
ENV PATH="/root/.local/bin:${PATH}"
RUN pip3 install --user ansible molecule molecule[openstack] docker-py python-vagrant


## Deployment Container
FROM python:3.8.0-alpine
LABEL maintainer="ulmer@ulmer.org"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="ulmer/ansible-engine-container"
LABEL org.label-schema.description="A small container from which to run Ansible."
LABEL org.label-schema.vcs-url="https://github.com/stephenulmer/ansible-engine-container"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.docker.cmd="docker run -it --rm -v \$(pwd):/work ulmer/ansible-engine-container:$VERSION"
LABEL version=$VERSION

RUN apk add --no-cache bash git
RUN adduser -g "Ansible User" -s /bin/bash -D ansible \
    && addgroup ansible root \
    && echo 'export PS1="\u:\w\$ "' >> /home/ansible/.bashrc
COPY --from=buildenv --chown=ansible:ansible /root/.local /home/ansible/.local

ENV PATH="/home/ansible/.local/bin:${PATH}"
USER ansible
VOLUME /work
WORKDIR /work

CMD ["/bin/bash"]
