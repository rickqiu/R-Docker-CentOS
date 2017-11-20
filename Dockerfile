FROM centos
MAINTAINER rick qiu

RUN mkdir -p /usr/share/doc/R-3.4.0/html
RUN yum -y update && yum clean all
RUN yum install wget -y
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ivh epel-release-latest-7.noarch.rpm
RUN yum install R -y

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('dplyr')"
RUN Rscript -e "install.packages('rJava')"
RUN Rscript -e "install.packages('RJDBC')"

COPY *.jar /workarea/
COPY *.rds /workarea/
RUN mkdir -p /home/geo/prov
COPY pgen_1.0.0.tar.gz /workarea/
COPY *.r /workarea/
RUN chmod +x /workarea/*.r
WORKDIR /workarea

RUN Rscript -e "install.packages('/workarea/pgen_1.0.0.tar.gz', repos=NULL, type='source')"
