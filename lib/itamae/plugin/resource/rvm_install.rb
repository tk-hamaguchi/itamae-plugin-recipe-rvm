module Itamae::Plugin::Resource
  class RvmInstall < ::Itamae::Resource::Base
    define_attribute :action, default: :install
    define_attribute :ruby_version, type: String, default_name: true

    def pre_action
      case @current_action
      when :install
        attributes.executed = true
      end
    end

    def set_current_attributes
      current.executed = false
    end

    def action_install(options)
      command = "/bin/bash --login -c 'rvm install #{attributes.ruby_version}'"
      run_command(command)
      updated!
    end
  end
end
