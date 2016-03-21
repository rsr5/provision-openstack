
chef_role 'os-compute-setup'
chef_role 'os-compute-conductor'
chef_role 'os-compute-scheduler'
chef_role 'os-compute-api'
chef_role 'os-compute-api-ec2'
chef_role 'os-compute-api-os-compute'
chef_role 'os-compute-api-metadata'

fragment 'os-compute' do
  run_list %w(
    os_base
    os-compute-setup
    os-compute-conductor
    openstack-compute::nova-setup
    openstack-compute::identity_registration
    openstack-compute::conductor
    openstack-compute::scheduler
    openstack-compute::api-ec2
    openstack-compute::api-os-compute
    openstack-compute::api-metadata
    openstack-compute::identity_registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
