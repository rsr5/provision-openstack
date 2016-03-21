chef_role 'os-image'
chef_role 'os-image-api'
chef_role 'os-image-registry'
chef_role 'os-image-upload'

fragment 'os-image' do
  memory_weight 250
  run_list %w(
    os_base
    os-image
    os-image-api
    os-image-registry
    os-image-upload
    openstack-image::api
    openstack-image::registry
    openstack-image::identity_registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
