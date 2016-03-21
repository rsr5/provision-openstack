
chef_role 'os-bare-metal-api'

fragment 'os-bare-metal-api' do
  memory_weight 100
  run_list %w(
    os_base
    openstack-bare-metal::api
    openstack-bare-metal::identity_registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
