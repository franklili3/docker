# Version 0.0.1
FROM centos:7
RUN sed -i.backup 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
COPY Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
MAINTAINER frank <348104201@qq.com>
LABEL Description="This image is used for fmz robot"
RUN yum update -y
RUN yum clean all && yum makecache fast
RUN yum install sudo gcc-c++ make python36 python36-devel zip unzip git wget -y
RUN yum clean all
RUN sudo rm /usr/bin/python
RUN sudo ln -s /usr/bin/python3.6 /usr/bin/python
RUN useradd noroot -u 10003 -s /bin/bash
RUN chmod -R ugo+rwx /home/noroot
COPY requirements.txt /home/noroot
USER noroot
RUN pip3 --no-cache-dir install --user --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ -r /home/noroot/requirements.txt
WORKDIR /home/noroot
RUN wget https://www.fmz.com/dist/robot_linux_amd64.tar.gz
RUN tar -xvzf robot_linux_amd64.tar.gz
