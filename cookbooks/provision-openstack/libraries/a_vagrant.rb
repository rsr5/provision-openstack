
module Fragments
  module Drivers
    # Mixin providing methods needed by all Vagrant drivers
    module VagrantMixin
      def vagrant_ssh_config(machine)
        return nil unless File.exist?(chef_root('vms'))
        command = "bash -c 'cd #{chef_root('vms')}; "\
                  "vagrant ssh-config #{machine.name}'"
        ssh_config = Mixlib::ShellOut.new(command).run_command.stdout
        return nil if ssh_config.size == 0
        ssh_config
      end

      def ipaddr(machine)
        ssh_config = vagrant_ssh_config(machine)
        return 'not known yet' unless ssh_config
        return @ip_addresses[machine.name] if @ip_addresses.key?(machine.name)
        host_line = ssh_config.split("\n").find do |l|
          l.start_with?('  HostName ')
        end
        @ip_addresses[machine.name] = host_line.split(' ')[1]
        @ip_addresses[machine.name]
      end

      def ssh_options(machine)
        ssh_config = vagrant_ssh_config(machine)
        return 'not known yet' unless ssh_config
        ' -o ' +
          vagrant_ssh_config(machine)
            .split("\n")
            .map(&:strip)
            .select { |line| !line.include?('Host') }
            .map { |option| option.split(' ').join('=') }
            .join(' -o ')
      end

      # Verifies that there is enough physical memory and cpus on the local
      # machine to accomodate the fragments being provisioned
      def pre_verify(packer)
        total = packer.machines.map(&:memory).inject { |a, e| a + e }
        physical = ::Chef.node['memory']['total'].to_i / 1024
        fail "The fragments chosen require (#{total}MB) more than three " \
             " of the physical memory (#{physical}MB) on this machine." \
               if total > (physical * 0.75)
      end
    end
  end
end
