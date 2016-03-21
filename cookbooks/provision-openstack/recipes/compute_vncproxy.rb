
chef_role 'os-compute-vncproxy'

fragment 'os-compute-vncproxy' do
  memory_weight 100
  run_list %w(
    os_base
    os-compute-vncproxy
    openstack-compute::vncproxy
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
