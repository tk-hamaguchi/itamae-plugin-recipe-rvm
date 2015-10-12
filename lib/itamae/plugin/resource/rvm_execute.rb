module Itamae::Plugin::Resource
  class RvmExecute < ::Itamae::Resource::Execute
    define_attribute :rvm_use, type: String, default: 'default'

    def set_current_attributes
      run_command('/bin/bash --login -c "which rvm-shell"', error: false)
        .stdout.strip.each_line do |line|
          current.rvm_shell = line
      end
      super
    end

    def action_run(options)
      attributes.command = "#{current.rvm_shell} #{attributes.rvm_use} -c '#{attributes.command}'"
      super
    end
  end
end
