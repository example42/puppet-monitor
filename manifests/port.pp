define monitor::port (
  $port,
  $protocol,
  $target,
  $tool,
  $checksource='remote',
  $enable=true
  ) {

  $bool_enable=any2bool($enable)

  $ensure = $bool_enable ? {
    false => 'absent',
    true  => 'present',
  }

  if ($tool =~ /munin/) {
  }

  if ($tool =~ /collectd/) {
  }

  if ($tool =~ /monit/) {
  }

  if ($tool =~ /nagios/) {
    nagios::service { "$name":
      ensure        => $ensure,
      check_command => $protocol ? {
        tcp => $checksource ? {
          local   => "check_nrpe!check_port_tcp!${target}!${port}",
          default => "check_tcp!${port}",
        },
        udp => $checksource ? {
          local   => "check_nrpe!check_port_udp!${target}!${port}",
          default => "check_udp!${port}",
        },
      }
    }
  }

  if ($tool =~ /puppi/) {
    puppi::check { "$name":
      enable   => $bool_enable,
      hostwide => 'yes',
      command  => $protocol ? {
        tcp => "check_tcp -H ${target} -p ${port}" ,
        udp => "check_udp -H ${target} -p ${port}" ,
      }
    }
  }

}
