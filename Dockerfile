# Based on debian
FROM debian:stable

# Install open-ssh server
RUN apt-get update && \
      apt-get install -y openssh-server && \
      rm -rf /var/lib/apt/lists/* && \
      apt-get clean

# Enable root login
RUN echo "" >> /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Environment variable, used to setup user password and port
ENV SSH_USER root
ENV SSH_PASS password

# Expose port
EXPOSE 22

# Copy over entrypoint file
COPY start.sh /start.sh

# Logging of entrypoint file into autobuilds
RUN chmod +x /start.sh && cat /start.sh

# Lets setup, and command arguments
ENTRYPOINT [ "/start.sh" ]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]
