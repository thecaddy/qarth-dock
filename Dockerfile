# DOCKER-VERSION 1.0.0

FROM dockerfile/ubuntu

# Update and install packages
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev python curl git ruby nano

# Install Node.js version 0.11.13 from source
RUN git clone https://github.com/joyent/node.git && \
    cd node && \
    git checkout v0.11.13 && \
    ./configure && make && sudo make install && \
    echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

# Add pull_repo script
RUN mkdir /home/scripts
ADD init.sh /home/scripts/init.sh

EXPOSE  8080

# Set the default command
CMD ["sh", "/home/scripts/init.sh"]
