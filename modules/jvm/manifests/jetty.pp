define jvm::jetty($secret,
				  $port,
				  $context="/",
				  $prefix="/var/apps",
				  $owner="deploy",
				  $group="users",
				  $ensure="present",
				  $run_prefix="/var/run",
				  $log_prefix="/var/log",
				  $jvm_args=[]) {

  $pidfile=${run_prefix}/${name}.pid
  $workdir=${log_prefix}/${name}
  $logdir=${log_prefix}/${name}
  $appdir=${prefix}/${name}
  $execjar=${appdir}/${name}

  if $ensure == 'present' {
    file { $workdir:
      ensure => directory,
      owner => $owner,
      group => $group,
    }

    file { $appdir:
      ensure => directory,
      owner => $owner,
      group => $group,
    }
   
    file { "/etc/init.d/${name}":
	  ensure => present,
	  content => template("jetty.sh.erb"),
	  notify => Service["${name}"],
      owner => root,
      group => root,
    }

	service { $name:
		ensure => running,
		hasstatus => true,
		require => File["/etc/init.d/${name}"],
		subscribe => File["$execjar"],
	}
	
  } elsif $ensure == 'absent' {
	service { $name:
		ensure => stopped,
	}

    file { $pidfile:
	  ensure => absent,
	}

    file { $appdir:
      ensure => absent,
      owner => $owner,
      group => $group,
      recurse => true,
      purge => true,
      force => true,
    }

    file { "/etc/init.d/${name}":
	  ensure => absent,
	}
  }

}
