# Version 0.0.1
FROM centos:7
RUN sed -i.backup 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
COPY Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
MAINTAINER frank <348104201@qq.com>
LABEL Description="This image is used for fmz robot"
# install cross compiler
#RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo && yum clean all && yum makecache
#RUN sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
# install python3.6
#RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
RUN yum update -y
RUN yum clean all && yum makecache fast
RUN yum install -y sudo gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
RUN yum install python36 python36-devel zip unzip git wget nodejs -y
RUN yum clean all
RUN sudo rm /usr/bin/python
RUN sudo ln -s /usr/bin/python3.6 /usr/bin/python
RUN useradd noroot -u 10003 -s /bin/bash
RUN chmod -R ugo+rwx /home/noroot
COPY requirements.txt /home/noroot
USER noroot
RUN pip3 --no-cache-dir install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ -r /home/noroot/requirements.txt --user
WORKDIR /home/noroot
RUN wget https://www.fmz.com/dist/robot_linux_amd64.tar.gz
RUN tar -xvzf robot_linux_amd64.tar.gz
#RUN git clone https://github.com/franklili3/pyfolio.git
#WORKDIR /home/noroot/pyfolio
#RUN git pull
#WORKDIR /home/noroot
