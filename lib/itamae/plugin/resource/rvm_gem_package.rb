module Itamae::Plugin::Resource
  class RvmGemPackage < ::Itamae::Resource::GemPackage
    define_attribute :rvm_use, type: String, default: 'default'

    alias_method :org_run_command, :run_command

    def run_command(cmd,option={})
      unless current.rvm_shell
        org_run_command('/bin/bash --login -c "which rvm-shell"', error: false)
          .stdout.strip.each_line do |line|
            current.rvm_shell = line
        end
      end

      ::Itamae.logger.debug "current.rvm_shell: #{current.rvm_shell}"

      command = "#{current.rvm_shell} #{attributes.rvm_use} -c '#{cmd.is_a?(Array) ? cmd.join(' ') : cmd}'"
      super(command, option)
    end
  end
end
