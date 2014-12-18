FROM shippableimages/ubuntu1404_nodejs

# MongoDB

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org

# Express
RUN npm install express -g

# MEAN.js
RUN npm install -g grunt-cli
RUN npm install -g bower

RUN apt-get install -y git
RUN git clone https://github.com/linnovate/mean.git

RUN cd /mean && \
    bower --allow-root install && \
    npm install

# runit
RUN apt-get install -y runit 
ADD sv /etc/service
CMD [ "/usr/sbin/runsvdir-start" ]
