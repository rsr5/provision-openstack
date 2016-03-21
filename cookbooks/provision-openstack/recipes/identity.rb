
chef_role 'os-identity'

fragment 'os-identity' do
  memory_weight 100
  run_list %w(
    os_base
    os-identity
    openstack-identity::server-apache
    openstack-identity::registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
