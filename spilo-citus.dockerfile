ARG PGMAJOR=13
ARG TIMESCALEDB_VERSION=2.2.1
#ARG SPILO_VERSION=2.0-p7
#FROM registry.opensource.zalan.do/acid/spilo-${PGMAJOR}:${SPILO_VERSION}
#ARG PGMAJOR=13.3
#FROM docker.io/timescale/timescaledb-ha:pg${PGMAJOR}-ts${TIMESCALE_VERSION}-latest
ARG SPILO_VERSION=2.0p7
FROM docker.io/zer0def/spilo:${PGMAJOR}-${SPILO_VERSION}-tsl${TIMESCALEDB_VERSION}

USER 0
RUN . /etc/os-release \
 && export DEBIAN_FRONTEND=noninteractive \
 && curl -sSL https://repos.citusdata.com/community/gpgkey | apt-key add - \
 && curl -sSL "https://repos.citusdata.com/community/config_file.list?os=${ID}&dist=${VERSION_CODENAME}" > /etc/apt/sources.list.d/citus.list \
 && apt update \
 && apt -y install \
      postgresql-12-citus-10.0 \
      postgresql-13-citus-10.0 \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

RUN apt update \
 && apt -y install \
      postgresql-9.6-citus-8.0 \
      postgresql-10-citus-8.3 \
      postgresql-11-citus-10.0 \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*
#USER 1000
