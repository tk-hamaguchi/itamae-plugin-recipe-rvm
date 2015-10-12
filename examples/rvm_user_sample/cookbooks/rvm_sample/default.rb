include_recipe 'rvm::user'

rvm_get '1.26.11' do
  user 'vagrant'
end

rvm_config '.rvmrc' do
  user 'vagrant'
end

rvm_install '2.2' do
  user 'vagrant'
end

rvm_gemset_create 'sample' do
  user 'vagrant'
  ruby_version '2.2'
end

rvm_execute 'ruby -v' do
  user 'vagrant'
  rvm_use '2.2@sample'
end

rvm_gem_package 'rspec' do
  user 'vagrant'
  rvm_use '2.2@sample'
end

rvm_execute 'gem list' do
  user 'vagrant'
  rvm_use '2.2@sample'
end

rvm_execute 'rspec -v' do
  user 'vagrant'
  rvm_use '2.2@sample'
end

