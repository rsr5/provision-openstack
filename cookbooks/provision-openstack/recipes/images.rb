chef_role 'os-image'
chef_role 'os-image-api' do
  run_list %w(
    recipe[openstack-image::api]
  )
end
chef_role 'os-image-registry' do
  run_list %w(
    recipe[openstack-image::registry]
  )
end
chef_role 'os-image-upload' do
  run_list %w(
    recipe[openstack-image::identity_registration]
  )
end

fragment 'os-image' do
  memory_weight 250
  run_list %w(
    os_base
    os-image
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
