From centos
WORKDIR /root/jenk2
COPY . /var/www/html
RUN  yum install  httpd -y
CMD [ "/usr/sbin/httpd","-D","FOREGROUND" ]
Expose 80