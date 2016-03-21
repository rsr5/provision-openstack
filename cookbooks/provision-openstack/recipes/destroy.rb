
cluster 'default' do
  packer 'modular'
  driver 'virtualbox'
  supermarket_url 'https://supermarket.chef.io'
  domain_name 'local'
end

packer 'default' do
  action :destroy
end

%w(vms
   .chef/backup
   .chef/cache
   .chef/clients
   .chef/cookbooks
   .chef/data_bags
   .chef/environments
   .chef/nodes
   .chef/roles
   .chef/secrets
).each do |dir|
  directory chef_root(dir) do
    action :delete
    recursive true
  end
end

%w(Berksfile.lock
   .chef/node.json
   dependencies.dot
).each do |path|
  file chef_root(path) do
    action :delete
  end
end
