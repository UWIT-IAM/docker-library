FROM centos:centos7

LABEL org.opencontainers.image.vendor="UW-IT" \
      org.opencontainers.image.authors="Justin Prosser"

# dump out container image details for the logs
RUN echo "hello centos (amd64, arm64, ppc64)"
RUN echo -n "current OS is: "; uname -p

# Pull latest CentOS 7 updates
RUN yum update -y
RUN yum erase -y linux-firmware
RUN yum clean all
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

CMD uname -a && sleep infinity
