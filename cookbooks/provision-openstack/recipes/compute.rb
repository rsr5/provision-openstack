
chef_role 'os-compute-setup'
chef_role 'os-compute-conductor'

fragment 'os-compute' do
  run_list %w(
    os_base
    os-compute-setup
    os-compute-conductor
    openstack-compute::nova-setup
    openstack-compute::identity_registration
    openstack-compute::conductor
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
