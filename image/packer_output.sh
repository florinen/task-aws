#!/usr/bin/env bash

set -e

packer build \
    golden_image.json | tee packer_output.txt

sudo cat packer_output.txt | tail -n 2 \ 
  | sed '$ d' \
  | sed "s/eu-west-1: /packer_build_ami = \"/" \
  | sed -e 's/[[:space:]]*$/\"/' > packer_ami.tfvars

sudo cat packer_ami.tfvars