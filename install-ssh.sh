sudo apt-get update \
&& sudo apt-get install openssh-server \
&& sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
&& sudo systemctl restart sshd \
&& sudo systemctl enable ssh
