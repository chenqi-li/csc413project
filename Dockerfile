ARG CUDA_VERSION=11.7
ARG OS_VERSION=22.04

FROM nvidia/cuda:${CUDA_VERSION}.1-cudnn8-devel-ubuntu${OS_VERSION}
LABEL org.opencontainers.image.authors="changwon.lee@mail.utoronto.ca"

ENV TZ Canada/Eastern
ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-c"]

#? System Packages
COPY apt_packages.txt apt_packages.txt
RUN apt-get update && \
    xargs -a apt_packages.txt apt-get install -y --no-install-recommends && \
    cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python &&\
    ln -s /usr/bin/pip3 pip;

#? Install basic python packages
COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install -U -r requirements.txt

#? Install PyTorch
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

#? Install Mmsegmentation
RUN pip3 install -U openmim
RUN mim install mmcv-full
RUN git clone https://github.com/open-mmlab/mmsegmentation.git && \
    cd mmsegmentation && \
    pip3 install -e .

#? Fix dependency errors
RUN pip3 install numpy==1.23.5

#? Other installations

WORKDIR /home
