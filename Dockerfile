# Version 0.0.1
FROM centos:8.0
AUTHOR frank <348104201@qq.com>
LABEL Description="This image is used for botvs sandbox"
# install cross compiler
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo && yum clean all && yum makecache
RUN sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
# install python3.6
RUN yum install sudo make python36 python36-devel zip unzip gcc git wget vixie-cron crontabs -y
RUN yum clean all
RUN sudo ln -s /usr/bin/python3.6 /usr/bin/python
RUN useradd noroot -u 1000 -s /bin/bash
RUN chmod -R ugo+rwx /home/noroot
COPY requirements.txt /home/noroot
RUN pip3 --no-cache-dir install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ -r /home/noroot/requirements.txt --user
USER noroot
WORKDIR /home/noroot
RUN wget https://www.fmz.com/dist/robot_linux_amd64.tar.gz
RUN tar -xvzf robot_linux_amd64.tar.gz
RUN git clone https://github.com/franklili3/pyfolio.git
ADD start.sh ./
CMD ["/bin/bash","./start.sh"]