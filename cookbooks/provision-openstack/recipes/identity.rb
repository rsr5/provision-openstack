
chef_role 'os-identity' do
  run_list %w(
    recipe[openstack-identity::server-apache]
    recipe[openstack-identity::registration]
  )
end

fragment 'os-identity' do
  memory_weight 100
  run_list %w(
    os_base
    os-identity
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
