#!/usr/bin/env bash
set -eux

# Architektur erkennen
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH_TAG="x86_64"
elif [[ "$ARCH" == "aarch64" ]]; then
    ARCH_TAG="aarch64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Falls schon vorhanden, alte Conda-Installation löschen
rm -rf /opt/conda

# Miniconda installieren
mkdir -p /opt/conda
cd /opt/conda
wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${ARCH_TAG}.sh" -O miniconda.sh
bash miniconda.sh -b -p /opt/conda -u
rm miniconda.sh
export PATH=/opt/conda/bin:$PATH

# Conda-SSL & ToS Fixes
export SSL_NO_VERIFY=1
conda config --set ssl_verify no
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main || true
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r || true

# Conda vorbereiten
conda init bash
conda config --add channels conda-forge

# Environment erstellen
conda create -y -n HSSE python=3.12
echo "conda activate HSSE" >> ~/.bashrc
source ~/.bashrc
conda activate HSSE

# Git Repo klonen
git clone https://github.com/Z3PP1X/HSSE_Webpage.git /backend
cd /backend/backend
git checkout "${HSSE_VERSION:-v1_stable}"
