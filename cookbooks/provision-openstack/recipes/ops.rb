chef_role 'os_base' do
  run_list %w(
    recipe[apt]
    recipe[yum]
    recipe[openstack-common]
    recipe[openstack-common::logging]
    recipe[openstack-common::set_endpoints_by_interface]
    recipe[openstack-common::sysctl]
  )
end

chef_role 'os-ops-database'
chef_role 'os-ops-messaging'

fragment 'os-ops' do
  memory_weight 100
  run_list %w(
    os-compute-single-controller-no-network
    os_base
    os-ops-database
    openstack-ops-database::server
    openstack-ops-database::openstack-db
    os-ops-messaging
    openstack-ops-messaging::server
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
