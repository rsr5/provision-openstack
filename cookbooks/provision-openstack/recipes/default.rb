cluster 'default' do
  packer 'modular'
  driver 'virtualbox'
  supermarket_url 'https://supermarket.chef.io'
  domain_name 'local'
end

include_recipe 'provision-openstack::berkshelf'
include_recipe 'provision-openstack::environments'
include_recipe 'provision-openstack::databags'
include_recipe 'provision-openstack::roles'
include_recipe 'provision-openstack::single-controller-no-network'

# require 'pry'; binding.pry

packer 'default' do
  action [
    :pack, # Calculate the number of virtual machine and pack the fragments
    :berkshelf_vendor, # Fetch the required cookbooks
    :provision, # Create the virtual machines
    :converge # Run Chef in the virtual machines
  ]
end
