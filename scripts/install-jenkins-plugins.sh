#!/usr/bin/env bash
set -o errexit

for config_file in $( find -L "configs/" -maxdepth 1 -type f -a \( -name '*.yaml' -o -name '*.yml' \) | sort ); do
  extra_vars+=( --extra-vars "@${config_file}" )
done

echo "Installing Jenkins plugins ..."

ANSIBLE_CONFIG=ansible/configs/ansible.cfg \
  ANSIBLE_LIBRARY=ansible/library/ \
  ansible-playbook "ansible/playbooks/install-jenkins-plugins.yaml" \
  "${extra_vars[@]}"

echo "Finished installing Jenkins plugins ..."