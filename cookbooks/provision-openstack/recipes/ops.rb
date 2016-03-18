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

chef_role 'os-ops-database' do
  run_list %w(
    role[os_base]
    recipe[openstack-ops-database::server]
  )
end

chef_role 'os-ops-messaging' do
  run_list %w(
    role[os_base]
    recipe[openstack-ops-messaging::server]
  )
end

fragment 'os-ops' do
  memory_weight 100
  run_list %w(
    os-compute-single-controller-no-network
    os_base
    os-ops-database
    openstack-ops-database::openstack-db
    os-ops-messaging
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
