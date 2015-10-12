module Itamae::Plugin::Resource
  class RvmConfig < ::Itamae::Resource::File
    define_attribute :action, default: %i(create edit)
    define_attribute :install_on_use_flag,       type: Integer, default: 1
    define_attribute :project_rvmrc,             type: Integer, default: 1
    define_attribute :gemset_create_on_use_flag, type: Integer, default: 1
    define_attribute :auto_reload_flag,          type: Integer, default: 2
    define_attribute :autoinstall_bundler_flag,  type: Integer, default: 1

    def pre_action
      user = attributes.user
      unless user
        user = run_command('id -un').stdout.strip
      end
      ::Itamae.logger.debug "user: #{user}"

      if rvm_path == '/usr/local/rvm'
        attributes.path = '/etc/rvmrc'
      else
        attributes.path = '.rvmrc'
      end
      ::Itamae.logger.debug "attributes.path: #{attributes.path}"

      case @current_action
      when :create
        attributes.exist = true
      when :delete
        attributes.exist = false
      when :edit
        attributes.exist = true

        content = backend.receive_file(attributes.path)
        %w(rvm_install_on_use_flag rvm_project_rvmrc rvm_gemset_create_on_use_flag rvm_auto_reload_flag rvm_autoinstall_bundler_flag).each do |key|
          content.gsub!(/[ \t]*#{key}[ \t]*=[ \t]*\w+[ \t]*\n?/,'')
        end
        content.gsub!(/\s*\z/,'')
        content.concat(<<-"EOS".gsub(/^\s+\|/, ''))
          |
          |rvm_install_on_use_flag=#{attributes.install_on_use_flag || 1}
          |rvm_project_rvmrc=#{attributes.project_rvmrc || 1}
          |rvm_gemset_create_on_use_flag=#{attributes.gemset_create_on_use_flag || 1}
          |rvm_auto_reload_flag=#{attributes.auto_reload_flag || 2}
          |rvm_autoinstall_bundler_flag=#{attributes.autoinstall_bundler_flag || 1}
        EOS
        attributes.content = content
      end

      send_tempfile
    end

    private

    def rvm_path
      current.rvm_path ||= begin
        match = run_command('/bin/bash --login -c "echo \$rvm_path"').stdout.match(/^(\/.+)$/)
        return nil unless match
        match[1].strip
      end
    end
  end
end
