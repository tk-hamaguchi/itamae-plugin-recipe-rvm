require 'itamae/plugin/resource/rvm_get'
require 'itamae/plugin/resource/rvm_install'
require 'itamae/plugin/resource/rvm_gemset_create'
require 'itamae/plugin/resource/rvm_execute'
require 'itamae/plugin/resource/rvm_gem_package'
require 'itamae/plugin/resource/rvm_config'

package 'curl'
package 'git'
package 'which'

node['rvm'] ||= {}
