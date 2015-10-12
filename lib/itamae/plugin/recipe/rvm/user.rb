include_recipe 'rvm::common'

if node['rvm']['user']
  rvm_get node['rvm']['version'] do
    user node['rvm']['user']
  end

  rvm_config '.rvmrc' do
    user node['rvm']['user']
    gemset_create_on_use_flag node['rvm']['gemset_create_on_use_flag']
    install_on_use_flag       node['rvm']['install_on_use_flag']
    project_rvmrc             node['rvm']['project_rvmrc']
    auto_reload_flag          node['rvm']['auto_reload_flag']
    autoinstall_bundler_flag  node['rvm']['autoinstall_bundler_flag']
  end
end
