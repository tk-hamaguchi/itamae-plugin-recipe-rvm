module Itamae::Plugin::Resource
  class RvmGemsetCreate < ::Itamae::Resource::Base
    define_attribute :action, default: :create
    define_attribute :ruby_version, type: String, required: true
    define_attribute :gemset_name,  type: String, default_name: true

    def pre_action
      case @current_action
      when :create
        attributes.executed = true
      end
    end

    def set_current_attributes
      current.executed = false
      run_command('/bin/bash --login -c "which rvm-shell"', error: false)
        .stdout.strip.each_line do |line|
          current.rvm_shell = line
      end
    end

    def action_create(options)
      command = "#{current.rvm_shell} #{attributes.ruby_version} -c 'rvm gemset create #{attributes.gemset_name}'"
      run_command(command)
      updated!
    end
  end
end
