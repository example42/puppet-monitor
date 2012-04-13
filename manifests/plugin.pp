# define monitor::plugin
#
# A monitor define to manage NAGIOS plugins
# It can be used to define monitoring via whatever Nagios plugin
# Note that the tools enabled could be whatever monitoring
# solution that is compatible or may use Nagios plugins
#
# == Parameters
#
# [*plugin*]
#   Name of the Nagios plugin. As it appears in the Nagios plugins path
#   (do not specify the full path, it's autocalculated for your OS)
#   Required argument
#
# [*tool*]
#   The monitoring tool to use. Currently supported: nagios, puppi
#   To add a monitoring tool (that supports the usage of Nagios plugins)
#   just add the relevant resources (local or exported) in the code
#
# [*arguments*]
#   The arguments to pass to the plugin.
#
# [*checksource*]
#   From where the check is executed:
#   local = Check is executed via Nrpe
#   remote = Check is executed from the Nagios server
#
# [*enable*]
#   Use this to enable or disable the check. Default: true
#
# == Example
#
#    monitor::plugin { "Fsi_Import_Errors":
#      plugin    => 'check_log' ,
#      arguments => '-F /store/tomcat/fsi/logs/FSIServerImporter.$(date +%Y-%m-%d).log -O /var/tmp/FSIServerImporter.log -q SQLException',
#      tool      => [ 'puppi' , 'nagios' ],
#    }
#
define monitor::plugin (
  $plugin,
  $tool,
  $arguments   = '',
  $checksource = 'local', # Note: Remote checksource might not work properly
  $enable      = true
  ) {

  $bool_enable = any2bool($enable)
  $safe_name = regsubst($name, '(/| )', '_', 'G')
  $ensure = $bool_enable ? {
    false => 'absent',
    true  => 'present',
  }

  if ($tool =~ /nagios/) {
    nagios::service { $safe_name:
      ensure        => $ensure,
      check_command => $checksource ? {
          local   => "check_nrpe!${safe_name}!blank",
          remote  => "${plugin}!${arguments}",
      },
    }

    # If plugin check is via nrpe, we create a local configuration entry
    if $checksource == local {
      file { "nrpe-check_${safe_name}":
        ensure  => $ensure,
        path    => "$nrpe::config_dir/check_${safe_name}.cfg",
        require => Package['nrpe'],
        notify  => $nrpe::manage_service_autorestart,
        replace => $nrpe::manage_file_replace,
        audit   => $nrpe::manage_audit,
        content => "command[$safe_name]=${nrpe::pluginsdir}/${plugin} ${arguments}\n",
      }
    }
  }

  if ($tool =~ /puppi/) {
    puppi::check { $safe_name:
      enable   => $bool_enable,
      hostwide => 'yes',
      command  => "${plugin} ${arguments}",
    }
  }

}

