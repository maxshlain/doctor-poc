#!/bin/bash
if ! which inspec;
then
  echo "Inspec not installed. Installing"
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
  echo "Inspec installation completed"
else
  echo "Inspec already installed"
fi

rm doctor.rb -f

wget --no-check-certificate -q https://github.com/maxshlain/doctor-poc/blob/main/doctor.rb

inspec exe doctor.rb
