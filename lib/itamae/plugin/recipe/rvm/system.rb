include_recipe 'rvm::common'

package 'sudo'

rvm_get node['rvm']['version'] do
  user 'root'
end

rvm_config '/etc/rvmrc' do
  user 'root'
  gemset_create_on_use_flag node['rvm']['gemset_create_on_use_flag']
  install_on_use_flag       node['rvm']['install_on_use_flag']
  project_rvmrc             node['rvm']['project_rvmrc']
  auto_reload_flag          node['rvm']['auto_reload_flag']
  autoinstall_bundler_flag  node['rvm']['autoinstall_bundler_flag']
end

