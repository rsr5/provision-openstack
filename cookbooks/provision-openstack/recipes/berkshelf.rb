
fragment 'openstack_github_cookbooks' do
  every_node true
  berkshelf Hash[
    %w(bare-metal
       data-processing
       integration-test
       object-storage
       orchestration
       telemetry
       block-storage
       common
       compute
       dashboard
       identity
       image
       network
       ops-database
       ops-messaging
    ).map do |cookbook|
      ["openstack-#{cookbook}",
       {
         github: "openstack/cookbook-openstack-#{cookbook}",
         branch: 'stable/liberty'
       }
      ]
    end
  ]
  machine_file(
    chef_root('.chef/encrypted_data_bag_secret'),
    '/etc/chef/openstack_data_bag_secret'
  )
end
