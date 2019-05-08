#!/bin/bash

# run packer (prints to stdout, but stores the output in a variable)
sudo packer_out=$(packer build golden_image.json | sudo tee /dev/tty)

# packer prints the id of the generated AMI in its last line
sudo ami=$(echo "$packer_out" | tail -c 30 | perl -n -e'/: (ami-.+)$/ && print $1')

# create the 'ami.tf' file from the template:
sudo export AMI_GENERATED_BY_PACKER="$ami" && envsubst < ami.tf.template > /root/task-aws/ami.tf