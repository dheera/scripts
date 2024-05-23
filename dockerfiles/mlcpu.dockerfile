# syntax = edrevo/dockerfile-plus

FROM ubuntu:jammy
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
INCLUDE+ ml.common
