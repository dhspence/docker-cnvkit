FROM ubuntu:latest
MAINTAINER David Spencer (dspencer@wustl.edu)

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y r-base-core
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('PSCBS', 'cghFLasso')"

RUN apt-get install -y \
    liblzma-dev \
    python-biopython \
    python-dev \
    python-matplotlib \
    python-numpy \
    python-pip \
    python-reportlab \
    python-scipy \
    python-tk \
    zlib1g-dev \
    emacs \
    emacs-goodies-el
    
RUN apt-get update -y && apt-get install -y libnss-sss

RUN apt-get update && apt-get install -y --no-install-recommends locales && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    LC_ALL=en_US.UTF-8 && \
    LANG=en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8 && \
    TERM=xterm
    
RUN pip install -U future futures pandas pyfaidx pysam
RUN pip install cnvkit==0.9.5
# Let matplotlib build its font cache
RUN cnvkit.py version

# ENTRYPOINT ["cnvkit.py"]
# CMD ["--help"]
CMD ["bash"]

