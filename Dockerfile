FROM amazonlinux

RUN yum update -y

ADD buildpkg.sh buildpkg.sh
RUN sh buildpkg.sh
