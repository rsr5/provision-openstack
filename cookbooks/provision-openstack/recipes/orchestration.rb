
chef_role 'os-orchestration'
chef_role 'os-orchestration-engine'
chef_role 'os-orchestration-api'
chef_role 'os-orchestration-api-cfn'
chef_role 'os-orchestration-api-cloudwatch'

fragment 'os-orchestration' do
  memory_weight 100
  run_list %w(
    os_base
    os-orchestration
    os-orchestration-engine
    os-orchestration-api
    os-orchestration-api-cfn
    os-orchestration-api-cloudwatch
    openstack-orchestration::engine
    openstack-orchestration::api
    openstack-orchestration::api-cfn
    openstack-orchestration::api-cloudwatch
    openstack-orchestration::identity_registration
  )
  environment 'vagrant-multi-neutron'
  tags %w(controller)
  only_group_with_tags %w(controller)
end
