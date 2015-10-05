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
