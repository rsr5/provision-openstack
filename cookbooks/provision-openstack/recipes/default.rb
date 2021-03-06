cluster 'default' do
  packer 'modular'
  driver 'virtualbox'
  supermarket_url 'https://supermarket.chef.io'
  domain_name 'local'
end

include_recipe 'provision-openstack::berkshelf'
include_recipe 'provision-openstack::environments'
include_recipe 'provision-openstack::databags'
include_recipe 'provision-openstack::single-controller-no-network'
include_recipe 'provision-openstack::ops'
include_recipe 'provision-openstack::identity'
include_recipe 'provision-openstack::images'
include_recipe 'provision-openstack::compute'
include_recipe 'provision-openstack::block_storage'
include_recipe 'provision-openstack::compute_cert'
include_recipe 'provision-openstack::compute_vncproxy'
include_recipe 'provision-openstack::bare_metal_api'
include_recipe 'provision-openstack::orchestration'
include_recipe 'provision-openstack::dashboard'

# require 'pry'; binding.pry

packer 'default' do
  action [
    :pack, # Calculate the number of virtual machine and pack the fragments
    :provision, # Create the virtual machines
    :berkshelf_vendor, # Fetch the required cookbooks
    :converge # Run Chef in the virtual machines
  ]
end
