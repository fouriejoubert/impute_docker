# This is the docker file for running impute on Ubuntu 
# The command is docker run -v /cluster:/cluster -t -i impute:latest /usr/local/impute_v2.3.2_x86_64_static/impute2 -m /usr/local/impute_v2.3.2_x86_64_static/Example/example.chr22.map -h /usr/local/impute_v2.3.2_x86_64_static/Example/example.chr22.1kG.haps -l /usr/local/impute_v2.3.2_x86_64_static/Example/example.chr22.1kG.legend -g /usr/local/impute_v2.3.2_x86_64_static/Example/example.chr22.reference.gens -strand_g /usr/local/impute_v2.3.2_x86_64_static/Example/example.chr22.study.strand -int 20.4e6 20.5e6 -Ne 20000

# Choose a base system
  
FROM ubuntu:latest
MAINTAINER Fourie Joubert <fourie.joubert@up.ac.za>

# Set up variables to get through UP proxy server

ENV http_proxy=http://f1jouber:M52nj37@137.215.6.50:8080

# Change the Ubuntu repo to the ftp.up.ac.za site

RUN echo "deb ftp://ftp.up.ac.za/mirrors/ubuntu/ubuntu xenial main multiverse restricted universe" > /etc/apt/sources.list

# Install some tools that we'll need

RUN apt-get update && apt-get install -y sudo wget tar
RUN cd /usr/local/; wget http://mathgen.stats.ox.ac.uk/impute/impute_v2.3.2_x86_64_static.tgz && tar -zxvf impute_v2.3.2_x86_64_static.tgz
RUN useradd -g 100 -s /bin/bash ubuntu

# Run impute on the included sample data

USER ubuntu

CMD ["/bin/bash	"] 
