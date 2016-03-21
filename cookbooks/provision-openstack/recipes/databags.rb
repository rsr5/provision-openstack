require 'chef/encrypted_data_bag_item'
require 'securerandom'
require 'fileutils'

secret = Chef::EncryptedDataBagItem.load_secret(
  chef_root('.chef/encrypted_data_bag_secret')
)

def random_pass(bag, item)
  path = chef_root(".chef/secrets/#{bag}/#{item}.txt")
  return 'SHOULD_NOT_EXIST' if File.exist?(path)

  x = SecureRandom.random_number(36**24).to_s(36).rjust(24, '0')
  FileUtils.mkdir_p(File.dirname(path))
  File.open(path, 'w') do |f|
    f.print("#{item}: #{x}\n")
  end
  x
end

bags = {
  'service_passwords' => {
    'openstack-orchestration' => {
      'id' => 'openstack-orchestration',
      'openstack-orchestration' => random_pass(
        'service_passwords',
        'openstack-orchestration'
      )
    },
    'openstack-ceilometer' => {
      'id' => 'openstack-ceilometer',
      'openstack-ceilometer' => random_pass(
        'service_passwords',
        'openstack-ceilometer'
      )
    },
    'openstack-block-storage' => {
      'id' => 'openstack-block-storage',
      'openstack-block-storage' => random_pass(
        'service_passwords',
        'openstack-block-storage'
      )
    },
    'openstack-image' => {
      'id' => 'openstack-image',
      'openstack-image' => random_pass(
        'service_passwords',
        'openstack-image'
      )
    },
    'openstack-compute' => {
      'id' => 'openstack-compute',
      'openstack-compute' => random_pass(
        'service_passwords',
        'openstack-compute'
      )
    },
    'openstack-network' => {
      'id' => 'openstack-network',
      'openstack-network' => random_pass(
        'service_passwords',
        'openstack-network'
      )
    },
    'rabbit_cookie' => {
      'id' => 'rabbit_cookie',
      'rabbit_cookie' => random_pass(
        'service_passwords',
        'rabbit_cookie'
      )
    },
    'openstack-bare-metal' => {
      'id' => 'openstack-bare-metal',
      'openstack-bare-metal' => random_pass(
        'service_passwords',
        'openstack-bare-metal'
      )
    }
  },
  'secrets' => {
    'openstack_identity_bootstrap_token' => {
      'id' => 'openstack_identity_bootstrap_token',
      'openstack_identity_bootstrap_token' => random_pass(
        'secrets',
        'openstack_identity_bootstrap_token'
      )
    },
    'neutron_metadata_secret' => {
      'id' => 'neutron_metadata_secret',
      'neutron_metadata_secret' => random_pass(
        'secrets',
        'neutron_metadata_secret'
      )
    },
    'openstack_metering_secret' => {
      'id' => 'openstack_metering_secret',
      'openstack_metering_secret' => random_pass(
        'secrets',
        'openstack_metering_secret'
      )
    },
    'orchestration_auth_encryption_key' => {
      'id' => 'orchestration_auth_encryption_key',
      'orchestration_auth_encryption_key' => random_pass(
        'secrets',
        'orchestration_auth_encryption_key'
      )
    }
  },
  'db_passwords' => {
    'nova' => {
      'id' => 'nova',
      'nova' => random_pass('db_passwords', 'nova')
    },
    'horizon' => {
      'id' => 'horizon',
      'horizon' => random_pass('db_passwords', 'horizon')
    },
    'keystone' => {
      'id' => 'keystone',
      'keystone' => random_pass('db_passwords', 'keystone')
    },
    'glance' => {
      'id' => 'glance',
      'glance' => random_pass('db_passwords', 'glance')
    },
    'ceilometer' => {
      'id' => 'ceilometer',
      'ceilometer' => 'quzrvna7x1vjxg38d4fyxg0c'
    },
    'neutron' => {
      'id' => 'neutron',
      'neutron' => random_pass('db_passwords', 'neutron')
    },
    'cinder' => {
      'id' => 'cinder',
      'cinder' => random_pass('db_passwords', 'cinder')
    },
    'heat' => {
      'id' => 'heat',
      'heat' => random_pass('db_passwords', 'heat')
    },
    'ironic' => {
      'id' => 'ironic',
      'ironic' => random_pass('db_passwords', 'ironic')
    },
    'repl_user' => {
      'id' => 'repl_user',
      'repl_user' => random_pass('db_passwords', 'repl_user')
    },
    'sqlmon' => {
      'id' => 'sqlmon',
      'sqlmon' => random_pass('db_passwords', 'sqlmon')
    }
  },
  'user_passwords' => {
    'admin' => {
      'id' => 'admin',
      'admin' => random_pass('user_passwords', 'admin')
    },
    'mysqlroot' => {
      'id' => 'mysqlroot',
      'mysqlroot' => random_pass('user_passwords', 'mysqlroot')
    },
    'guest' => {
      'id' => 'guest',
      'guest' => random_pass('user_passwords', 'guest')
    },
    'replication' => {
      'id' => 'replication',
      'replication' => random_pass('user_passwords', 'replication')
    },
    'osmon' => {
      'id' => 'osmon',
      'osmon' => random_pass('user_passwords', 'osmon')
    },
    'rabmon' => {
      'id' => 'rabmon',
      'rabmon' => random_pass('user_passwords', 'rabmon')
    },
    'backup' => {
      'id' => 'backup',
      'backup' => random_pass('user_passwords', 'backup')
    },
    'heat_stack_admin' => {
      'id' => 'heat_stack_admin',
      'heat_stack_admin' => random_pass('user_passwords', 'heat_stack_admin')
    }
  }
}

bags.each do |item, data|
  data.each do |name, params|
    puts "NAME #{name}"
    puts "PARAMS #{params.inspect}"
    path = chef_root(".chef/data_bags/#{item}/#{name}.json")
    dirname = ::File.dirname(path)
    if File.exist?(path)
      puts "data_bags/#{item}/#{name}.json exists, skipping"
    else
      FileUtils.mkdir_p(dirname)
      enc = Chef::EncryptedDataBagItem.encrypt_data_bag_item(params, secret)
      File.open(path, 'w') do |f|
        f.print JSON.pretty_generate(enc)
      end
    end
  end
end
