# OpenStack provisioning uses some encrypted databags, for now they will just
# be fetched from the openstack chef repository

git "#{Chef::Config[:file_cache_path]}/openstack_chef" do
  repository 'https://github.com/openstack/openstack-chef-repo.git'
  action :sync
end

bash 'sync data bags' do
  code <<-EOH
    rsync -avz #{Chef::Config[:file_cache_path]}/openstack_chef/data_bags \
      #{chef_root}.chef
    cp #{chef_root}.chef/data_bags/db_passwords/mysqlroot.json \
      #{chef_root}.chef/data_bags/user_passwords/
  EOH
end
