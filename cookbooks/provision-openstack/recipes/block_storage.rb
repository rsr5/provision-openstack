
chef_role 'os-block-storage'
chef_role 'os-block-storage-api'
chef_role 'os-block-storage-scheduler'
chef_role 'os-block-storage-volume'
chef_role 'os-block-storage-backup'

fragment 'os-block-storage' do
  memory_weight 200
  run_list %w(
    os-block-storage
    os-block-storage-api
    os-block-storage-scheduler
    os-block-storage-volume
    os-block-storage-backup
    openstack-block-storage::api
    openstack-block-storage::scheduler
    openstack-block-storage::volume
    openstack-block-storage::backup
    openstack-block-storage::identity_registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
