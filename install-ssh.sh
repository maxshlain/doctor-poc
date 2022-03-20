apt-get update \
&& apt-get install openssh-server \
&& sed -i ''s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g'' /etc/ssh/sshd_config
&& systemctl restart sshd
&& systemctl enable ssh
