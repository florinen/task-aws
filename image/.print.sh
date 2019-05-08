#!/bin/bash

# run packer (prints to stdout, but stores the output in a variable)
packer_out=$(packer build golden_image.json |  tee output.txt)

# packer prints the id of the generated AMI in its last line
ami=$(echo "$packer_out" | tail -c 30 | perl -n -e'/: (ami-.+)$/ && print $1')





#packer build golden_image.json  2>&1 | sudo tee output.txt
#tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > sudo ami.txt

# create the 'ami.tf' file from the template:
export AMI_GENERATED_BY_PACKER= "$ami" && envsubst < ami.tf.template > /root/task-aws/ami.tf
