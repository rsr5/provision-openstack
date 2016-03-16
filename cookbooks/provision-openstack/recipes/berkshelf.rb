
fragment 'openstack_github_cookbooks' do
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
end
