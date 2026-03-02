# syntax = edrevo/dockerfile-plus

FROM ubuntu:noble
RUN apt-get update && apt-get install -y python3-pip
RUN apt-get install python3-arrow python3-pandas python3-numpy python3-scipy python3-tqdm python3-yaml python3-tornado python3-matplotlib curl wget -y
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --break-system-packages
