$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'itamae/plugin/recipe/rvm'

require 'serverspec'

case ENV['BACKEND']
when 'docker'
  require 'docker'
  set :backend, :docker
  set :docker_url, ENV['DOCKER_HOST']
  set :docker_image, ENV['DOCKER_IMAGE']
  Excon.defaults[:ssl_verify_peer] = false
when 'vagrant'
  set :backend, :ssh
  host = ENV['TARGET_HOST']
  config = Tempfile.new('', Dir.tmpdir)
  config.write(`cd tmp/aruba && vagrant ssh-config #{host}`)
  config.close
  options = Net::SSH::Config.for(host, [config.path])
  options[:user] ||= 'vagrant'
  set :host,        options[:host_name] || host
  set :ssh_options, options
else
  fail 'You should set backend.'
end

