FROM ubuntu:16.04

# Install Python3.6.
# Note: on Travis it's 3.6.7 whereas deadsnakes repo provides 3.6.12
RUN apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:deadsnakes/ppa \
 && apt update \
 && apt install -y python3.6 python3.6-dev python3.6-venv python3-pip

# Create virtual environment
RUN python3.6 -m venv .venv

# Install Java (identical to how it's done on Travis)
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && apt-get update -qq \
 && apt-get install -y openjdk-8-jdk \
 && update-java-alternatives -s java-1.8.0-openjdk-amd64

# Setting environment variables
ENV PYTHONHASHSEED 0
ENV PYTHONPATH $PYTHONPATH:$PWD/answers
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH /.venv/bin:$PATH

RUN pip install pyspark pytest "dask[complete]"

ENTRYPOINT ["/bin/bash"]





