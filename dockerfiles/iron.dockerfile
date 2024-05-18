FROM ros:iron

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
    graphicsmagick \
    ffmpeg \
    libx264-dev

RUN pip3 install numpy scipy tqdm tornado

