include_recipe 'common.rb'

execute 'install rvm' do
  user 'root'
  command '\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundle'
  not_if 'ls /usr/local/rvm'
end

file '/etc/rvmrc' do
  user 'root'
  action :edit
  block do |content|
    content.concat(<<-"EOS".gsub(/^\s+\|/, ''))
      |
      |### Itamae cooked
      |rvm_install_on_use_flag=1
      |rvm_project_rvmrc=1
      |rvm_gemset_create_on_use_flag=1
      |### Itamae cooked
    EOS
  end
  not_if "grep '^### Itamae cooked$' /etc/rvmrc"
end


