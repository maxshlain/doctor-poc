#!/bin/bash
if ! which inspec;
then
  echo "Inspec not installed. Installing"
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
  inspec --chef-license=accept-silent
  echo "Inspec installation completed"
else
  echo "Inspec already installed"
fi

rm doctor.rb -f

wget --no-check-certificate -q https://maxshlain.github.io/doctor-poc/doctor.rb

inspec exe doctor.rb
