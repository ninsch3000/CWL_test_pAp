# Set the base image to Ubuntu 
FROM ubuntu:14.04 

# Update the repository sources list and install essential libraries 
RUN apt-get update && apt-get install --yes build-essential wget

# Downlaod and install fastx_toolkit
RUN wget http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 && \ 
    tar xvjf fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 

# File Author / Maintainer 
MAINTAINER Jonas Schurr
