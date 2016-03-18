
chef_role 'os_base' do
  run_list %w(
    recipe[apt]
    recipe[yum]
    recipe[openstack-common]
    recipe[openstack-common::logging]
    recipe[openstack-common::set_endpoints_by_interface]
    recipe[openstack-common::sysctl]
  )
end

chef_role 'os-ops-database' do
  run_list %w(
    role[os_base]
    recipe[openstack-ops-database::server]
  )
end

chef_role 'os-ops-messaging' do
  run_list %w(
    role[os_base]
    recipe[openstack-ops-messaging::server]
  )
end

chef_role 'os-identity' do
  run_list %w(
    recipe[openstack-identity::server-apache]
    recipe[openstack-identity::registration]
  )
end

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
