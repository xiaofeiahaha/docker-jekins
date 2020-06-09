FROM daocloud.io/library/centos:centos8
#工作目录
ARG DIR=/home/admin/app
#jenkins的安装包，我的服务器网络环境比较差，wget不下来
ARG JENKINS_RPM_NAME=jenkins-2.222.4-1.1.noarch.rpm
#工作目录
WORKDIR ${DIR}
#拷贝文件
COPY ${JENKINS_RPM_NAME} ${DIR}
## 依赖
RUN  yum install -y initscripts \
	 && yum -c /etc/yum.conf --installroot=${DIR}/jenkins --releasever=/ -y install java \
	 && rpm -ivh ${JENKINS_RPM_NAME} \
	 && yum -y install jenkins \
	 && rm -rf ${JENKINS_RPM_NAME}
#服务暴露
EXPOSE 8080/tcp	 
## 一些想到要装的工具
RUN yum -y install vim \
	&& echo "alias ll='ls -l'" >> ~/.bashrc \
	&& source ~/.bashrc
## 启动脚本
COPY deploy.sh ${DIR}
## 权限
RUN chmod 777 deploy.sh
#执行启动脚本
ENTRYPOINT ["/bin/bash","deploy.sh"]