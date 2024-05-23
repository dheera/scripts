# syntax = edrevo/dockerfile-plus

FROM nvidia/cuda:12.1.1-devel-ubuntu22.04
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install torch torchvision torchaudio
INCLUDE+ ml.common

RUN pip3 install \
    accelerate \
    xformers
