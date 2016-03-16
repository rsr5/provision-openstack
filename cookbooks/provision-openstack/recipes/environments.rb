chef_environment 'vagrant-multi-neutron' do
  description <<-ENV
Environment used in testing the upstream cookbooks and reference Chef
repository with vagrant. To be used with the Vagrantfile-multi-neutron
vagrantfile. Defines the necessary attributes for a working mutltinode
(1 controller/n computes) openstack deployment, using neutron (with gre
tunnels between hosts) for the networking component.'
ENV
  override_attributes(
    'mysql' => {
      'allow_remote_root' => true,
      'root_network_acl' => ['%']
    },
    'openstack' => {
      'mq' => {
        'user' => 'admin'
      },
      'identity' => {
        'bind_interface' => 'eth1'
      },
      'endpoints' => {
        'host' => '192.168.100.60',
        'bind-host' => '192.168.100.60',
        'mq' => {
          'host' => '192.168.100.60'
        },
        'db' => {
          'host' => '192.168.100.60'
        },
        'image-api-bind' => {
          'host' => '192.168.100.60'
        },
        'image-api' => {
          'host' => '192.168.100.60'
        },
        'compute-vnc-bind' => {
          'host' => '0.0.0.0',
          'bind_interface' => 'eth1'
        },
        'compute-vnc' => {
          'host' => '0.0.0.0',
          'bind_interface' => 'eth1'
        }
      },
      'network' => {
        'service_plugins' => [
          'neutron.services.l3_router.l3_router_plugin.L3RouterPlugin'
        ],
        'dhcp' => {
          'enable_isolated_metadata' => 'True'
        },
        'openvswitch' => {
          'tunnel_id_ranges' => '1 =>1000',
          'enable_tunneling' => 'True',
          'tunnel_type' => 'gre',
          'tenant_network_type' => 'gre'
        },
        'api' => {
          'bind_interface' => 'eth1'
        },
        'quota' => {
          'floatingip' => '50'
        },
        'l3' => {
          'external_network_bridge_interface' => 'eth1'
        }
      },
      'block-storage' => {
        'volume' => {
          'create_volume_group' => true,
          'default_volume_type' => 'lvm'
        }
      },
      'image' => {
        'api' => {
          'bind_interface' => 'eth1'
        },
        'registry' => {
          'bind_interface' => 'eth1'
        },
        'image_upload' => true,
        'upload_images' => [
          'cirros'
        ],
        'upload_image' => {
          # rubocop:disable Metrics/LineLength
          'cirros' => 'https =>//launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img'
        }
      },
      'compute' => {
        'enabled_apis' => 'ec2,osapi_compute',
        'novnc_proxy' => {
          'bind_interface' => 'eth1',
          'bind_address' => '0.0.0.0'
        },
        'libvirt' => {
          'virt_type' => 'qemu'
        },
        'network' => {
          'public_interface' => 'eth1',
          'service_type' => 'neutron'
        },
        'config' => {
          'ram_allocation_ratio' => 5.0
        }
      },
      'orchestration' => {
        'heat_stack_user_role' => 'heat_stack_user',
        'stack_user_domain_name' => 'heat',
        'stack_domain_admin' => 'heat_stack_admin'
      }
    }
  )
end
