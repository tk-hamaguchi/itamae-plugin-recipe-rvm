Itamae::Plugin::Recipe::Rvm
========

Itamae plugin for Setup Rvm.

Installation
--------

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-rvm'
```

And then execute:

```sh
$ bundle
```

Usage
--------

Include your recipe.

```ruby cookbooks/rvm/default.rb
package 'sudo'
include_recipe 'rvm::system'
```

Then execute itamae.

For example.

Docker:
```sh
$ itamae docker cookbooks/rvm/default.rb --image={YOUR_IMAGE_NAME} --no-tls-verify-peer
```

Vagrant:
```sh
$ itamae ssh --vagrant --host {YOUR_HOST_NAME} cookbooks/rvm/default.rb
```
