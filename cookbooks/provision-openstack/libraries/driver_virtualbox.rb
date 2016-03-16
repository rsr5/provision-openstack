require 'chef/provisioning/vagrant_driver'

include Fragments::Drivers

# Contains the driver setup code for Chef Provisioning
class VirtualBoxDriver < Driver
  include VagrantMixin

  def name
    'VirtualBox'
  end

  def configure
    @chef_provisioning.with_driver(
      "vagrant:#{chef_root('vms')}"
    )

    fetch_box

    @ip_addresses = {}
  end

  def fetch_box
    box = ::Chef::Resource::VagrantBox.new(
      'ubuntu14',
      ::Chef.node.run_context
    )
    box.url 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/'\
            'opscode_ubuntu-14.04_chef-provisionerless.box'
    box.run_action(:create)
  end

  def extra_machine_options(_machine)
    {
      vagrant_options: {
        'vm.box' => 'ubuntu14'
      }
    }
  end
end

Driver.register('virtualbox', VirtualBoxDriver)
