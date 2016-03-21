
chef_role 'os-compute-cert'

fragment 'os-compute-cert' do
  memory_weight 50
  run_list %w(
    os_base
    os-compute-cert
    openstack-compute::nova-cert
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
