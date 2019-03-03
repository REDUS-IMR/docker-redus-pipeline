FROM redusimr/redus-pipeline

LABEL org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/docker-redus-pipeline" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

ADD projects /root/workspace/projects

WORKDIR /root/workspace/projects

EXPOSE 8888

CMD /etc/run.sh & \
    (./process.sh \
    && tar czf results.tar.gz * --exclude='.*' ) > global.Rout 2> global.Rerr & \
    /bin/sh
