# docker push anuldbee10/jenk-kube:tagname
FROM centos 
WORKDIR /projects/jenkins
RUN yum install wget initscripts -y
RUN yum install git -y
RUN yum install sudo -y
RUN wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
RUN yum install java -y 
RUN yum install jenkins -y --nobest
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
RUN echo "jenkins:jenkins" | chpasswd 
RUN chmod 0440 /etc/sudoers 
EXPOSE 8080

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/  curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt /bin/linux/amd64/kubectl
RUN chmod +x kubectl 
RUN cp kubectl /usr/bin
COPY ca.crt /projects/jenkins 
COPY client.crt  /projects/jenkins 
COPY client.key /projects/jenkins

COPY config.yml /root/.kube/config

RUN chown -R jenkins /root/.kube 
COPY . /projects/jenkins
CMD ["java","-jar","/usr/lib/jenkins/jenkins.war"]