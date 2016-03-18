
chef_role 'os-compute-setup' do
  run_list %w(
    recipe[openstack-compute::nova-setup]
    recipe[openstack-compute::identity_registration]
  )
end
