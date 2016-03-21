
chef_role 'os-dashboard'

fragment 'os-dashboard' do
  memory_weight 100
  run_list %w(
    os_base
    os-dashboard
    openstack-dashboard::server
  )
end
