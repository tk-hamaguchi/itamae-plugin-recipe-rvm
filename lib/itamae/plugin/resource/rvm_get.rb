module Itamae::Plugin::Resource
  class RvmGet < ::Itamae::Resource::Base
    DEFAULT_GPG_KEY = '409B6B1796C275462A1703113804BB82D39DC0E3'

    define_attribute :action, default: :install
    define_attribute :version, type: String, default_name: true
    define_attribute :gpg_key, type: String, default: DEFAULT_GPG_KEY

    def pre_action
      case @current_action
      when :install
        attributes.gpg_installed = true
        attributes.version ||= 'latest'
      end
    end

    def set_current_attributes
      current.gpg_installed = gpgkey_installed?
      ::Itamae.logger.debug "GPG-Key was #{"not " unless current.gpg_installed}installed."

      return true unless current.gpg_installed

      version = installed_rvm
      current.installed = !!version
      if version == attributes.version
        current.version = attributes.version.strip
      else
        current.version = version
      end

      if current.installed
        ::Itamae.logger.debug "Current RVM version: #{current.version}"
      else
        ::Itamae.logger.debug 'RVM was not installed.'
      end
    end

    def action_install(options)
      install_gpgkey! unless current.gpg_installed
      ::Itamae.logger.debug "GPG-Key(#{attributes.gpg_key}) was installed."

      if current.installed
        if attributes.version && current.version != attributes.version.strip
          install!
          updated!
        end
      else
        install!
        updated!
      end
    end

    private

    def gpgkey_installed?
      (run_command('gpg --list-key').stdout =~ /\/#{attributes.gpg_key[-8,8]}\s+/)
    end

    def installed_rvm
      match = run_command("/bin/bash --login -c 'rvm version'", error: false)
                .stdout
                .match(/\s*rvm\s+(\d+\.\d+\.\d+)\s+\(/)
      return nil unless match
      match[1].strip
    end

    def install_gpgkey!
      cmd = "gpg --keyserver hkp://keys.gnupg.net --recv-keys #{attributes.gpg_key}"
      run_command(cmd)
    end

    def install!
      ::Itamae.logger.debug "attributes.version: #{attributes.version}"
      run_command("\\curl -sSL https://get.rvm.io | bash -s -- --version #{attributes.version}")
    end
  end
end
