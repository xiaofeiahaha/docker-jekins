FROM daocloud.io/library/centos:centos8
RUN yum install -y java \
	 && wget http://pkg.jenkins-ci.org/redhat-stable/jenkins-2.222.4-1.1.noarch.rpm \
	 && rpm -ivh jenkins-2.7.3-1.1.noarch.rpm
CMD ["service jenkins start/stop/restart"]