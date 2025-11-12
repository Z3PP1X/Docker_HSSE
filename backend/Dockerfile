FROM python:3.12-bookworm AS base
LABEL maintainer="z3pp1x"
ENV SSL_NO_VERIFY=1

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    SHELL=/bin/bash
ENV PATH="/py/bin:$PATH"

RUN apt update && \
    apt -y upgrade && \
    apt install -y --no-install-recommends \
        software-properties-common \
        build-essential \
        bash \
        dos2unix \
        git \
        ncdu \
        net-tools \
        dnsutils \
        inetutils-ping \
        openssh-server \
        libglib2.0-0 \
        libsm6 \
        libgl1 \
        libxrender1 \
        libxext6 \
        wget \
        curl \
        psmisc \
        rsync \
        vim \
        zip \
        unzip \
        htop \
        screen \
        tmux \
        aria2 \
        cron \
        pkg-config \
        libcairo2-dev \
        libgoogle-perftools4 \
        libtcmalloc-minimal4 \
        apt-transport-https \
        ca-certificates && \
    update-ca-certificates && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen

### Stage 2: Install HSSE Backend
WORKDIR /
ARG HSSE_VERSION
ARG PYTHON_VERSION
COPY --chmod=755 build/install.sh /install.sh
RUN /install.sh && rm /install.sh
ENV PATH="/opt/conda/bin:$PATH"

### Stage 3: Install Dependencies

WORKDIR /backend
RUN /opt/conda/envs/HSSE/bin/pip install --upgrade pip && \
    /opt/conda/envs/HSSE/bin/pip install -r requirements.txt && \
    /opt/conda/envs/HSSE/bin/pip install gunicorn

COPY build/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


RUN adduser --disabled-password --no-create-home z3pp1x && \
    chown -R z3pp1x:z3pp1x /backend

RUN mkdir -p /backend/staticfiles /backend/media && \
    chown -R z3pp1x:z3pp1x /backend/staticfiles /backend/media

USER z3pp1x
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]



