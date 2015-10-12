Itamae::Plugin::Recipe::Rvm
========

Itamae plugin for Rvm.

Installation
--------

Add this line to your application's Gemfile:

``` ruby
gem 'itamae-plugin-recipe-rvm'
```

And then execute:

```sh
$ bundle
```

Usage1: System RVM
--------

Include your recipe (ex:`cookbooks/rvm/default.rb`).
``` ruby
include_recipe 'rvm::system'
```

Then execute itamae.

For example.

Vagrant:
``` sh
$ itamae ssh --vagrant --host {YOUR_HOST_NAME} cookbooks/rvm/default.rb
```

If you have to config params then You should set node.yml

``` yaml
rvm:
  version: 1.26.11
  gemset_create_on_use_flag: 1
  install_on_use_flag: 1
  project_rvmrc: 1
  auto_reload_flag: 2
  autoinstall_bundler_flag: 1
```
Then execute itamae with --node-yaml= option.

For example.

Vagrant:
``` sh
$ itamae ssh --vagrant --host {YOUR_HOST_NAME} cookbooks/rvm/default.rb --node-yaml=node.yml
```

If you install ruby and create gemset, append your recipe.

``` ruby
rvm_install '2.2' do
  user 'root'
end

rvm_gemset_create 'sample' do
  user 'root'
  ruby_version '2.2'
end
```

And you install gem and execute commands.

``` ruby
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
```

Usage2: User RVM
--------

Include your recipe (ex:`cookbooks/rvm/default.rb`).
``` ruby
include_recipe 'rvm::user'
```

And add config to `node.yml`

``` yaml
rvm:
  user: vagrant
```

Then execute itamae.

For example.

Vagrant:

``` sh
$ itamae ssh --vagrant --host {YOUR_HOST_NAME} cookbooks/rvm/default.rb --node-yaml=node.yml
```

If you have to config params then You should set node.yml

``` yaml
rvm:
  user: vagrant
  version: 1.26.11
  gemset_create_on_use_flag: 1
  install_on_use_flag: 1
  project_rvmrc: 1
  auto_reload_flag: 2
  autoinstall_bundler_flag: 1
```

Then re-execute itamae.

If you install ruby and create gemset, append your recipe.

``` ruby
rvm_install '2.2' do
  user 'vagrant'
end

rvm_gemset_create 'sample' do
  user 'vagrant'
  ruby_version '2.2'
end
```

And you install gem and execute commands.

``` ruby
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
```
