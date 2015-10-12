include_recipe 'rvm::system'

rvm_get '1.26.11' do
  user 'root'
end

rvm_config '.rvmrc' do
  user 'root'
end

rvm_install '2.2' do
  user 'root'
end

rvm_gemset_create 'sample' do
  user 'root'
  ruby_version '2.2'
end

rvm_execute 'ruby -v' do
  user 'root'
  rvm_use '2.2@sample'
end

rvm_gem_package 'rspec' do
  user 'root'
  rvm_use '2.2@sample'
end

rvm_execute 'gem list' do
  user 'root'
  rvm_use '2.2@sample'
end

rvm_execute 'rspec -v' do
  user 'root'
  rvm_use '2.2@sample'
end

