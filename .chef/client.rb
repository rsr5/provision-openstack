current_dir = Dir.getwd
chef_repo_path current_dir + '/.chef/'
cookbook_path [current_dir + '/.chef/cookbooks']
file_cache_path current_dir + '/.chef/cache'
file_backup_path current_dir + '/.chef/backup'
chef_zero.enabled true
local_mode true
chef_server_url 'http://localhost:8901'
