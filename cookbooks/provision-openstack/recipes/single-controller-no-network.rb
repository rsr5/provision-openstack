# rubocop:disable Style/FileName

chef_role 'os-compute-single-controller-no-network'

fragment 'os-compute-single-controller-no-network' do
  memory_weight 500
  run_list %w(
    os-compute-single-controller-no-network
    os_base
    os-ops-database
    openstack-ops-database::openstack-db
    os-ops-messaging
    os-identity

    os-image
    os-image-api
    openstack-image::identity_registration
    os-image-upload
  )
  machine_option(
    vagrant_config: <<-ENDCONFIG
  config.vm.network "forwarded_port", guest: 443, host: 9443 # dashboard-ssl
  config.vm.network "forwarded_port", guest: 4002, host: 4002
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 8773, host: 8773 # compute-ec2-api
  config.vm.network "forwarded_port", guest: 8774, host: 8774 # compute-api
  config.vm.network "forwarded_port", guest: 35357, host: 35357
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.network "private_network", ip: "192.168.100.60"
  config.vm.network "private_network", ip: "192.168.200.60"
ENDCONFIG
  )
  environment 'vagrant-multi-neutron'
end
