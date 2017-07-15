FROM centos:latest

COPY pgen_1.0.0.tar.gz /workarea/
COPY *.rds /workarea/
COPY *.jar /workarea/ 
COPY *.r /workarea/
RUN chmod +x /workarea/*.r
WORKDIR /workarea

RUN mkdir -p /usr/share/doc/R-3.4.0/html
RUN mkdir -p /home/geo/prov
RUN yum install wget -y
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
RUN rpm -ivh epel-release-7-10.noarch.rpm
RUN yum install R -y
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('rJava')"
RUN Rscript -e "install.packages('RJDBC')"
RUN Rscript -e "install.packages('dplyr')"
RUN Rscript -e "install.packages('/workarea/pgen_1.0.0.tar.gz', repos=NULL, type='source')"
