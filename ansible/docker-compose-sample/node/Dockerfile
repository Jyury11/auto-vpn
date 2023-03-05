FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server vim python3

RUN mkdir /var/run/sshd

ARG ROOT_PASSWORD=root
RUN echo root:${ROOT_PASSWORD} | chpasswd

RUN sed -i 's/#\?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

WORKDIR /workspace

RUN mkdir ~/.ssh

EXPOSE 22

COPY ./sshkey.sh /workspace/sshkey.sh
RUN chmod a+x /workspace/sshkey.sh

CMD ["sleep", "infinity"]
