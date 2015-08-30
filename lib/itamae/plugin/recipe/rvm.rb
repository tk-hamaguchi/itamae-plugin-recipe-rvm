
execute 'install GPG-Key' do
  user 'root'
  command 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  not_if 'gpg --list-key | grep D39DC0E3'
end

package 'curl' do
  action :install
end

package 'git' do
  action :install
end

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


