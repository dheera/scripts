FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    vim \
    screen \
    htop \
    python3-pip \
    wget \
    curl \
    stress \
    git \
    git-lfs \
    imagemagick

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
RUN eval "$(/$HOME/miniconda/bin/conda shell.bash hook)" && conda config --set auto_activate_base true

RUN pip3 install torch torchvision torchaudio

