#!/bin/bash
echo "
{
  \"run_list\": [
    \"provision-openstack::destroy\"
  ],
  \"fragments\": {
    \"chef-zero-root\": \"$(pwd)\"
  }
}" > .chef/node.json

rm Berksfile.lock
berks vendor .chef/cookbooks;
chef-client -j .chef/node.json -c .chef/client.rb
