define jvm::jetty($secret,
                  $port,
				  $ensure=present,
                  $context_path="/",
                  $prefix="/var/apps",
                  $owner="deploy",
                  $group="users",
                  $ensure="present",
                  $run_prefix="/var/run",
                  $log_prefix="/var/log",
                  $jvm_args=[]) {

			notice("dbg: ${run_prefix} ... ${name}")

  $pidfile="${run_prefix}/${name}.pid"
  $workdir="${log_prefix}/${name}"
  $logdir="${log_prefix}/${name}"
  $appdir="${prefix}/${name}"
  $exec_jar="${appdir}/${name}.jar"

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
      ensure => enabled,
      hasstatus => true,
      require => File["/etc/init.d/${name}"],
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

