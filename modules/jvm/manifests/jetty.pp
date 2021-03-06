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
                  $cache_prefix="/var/cache",
                  $jvm_args=[]) {

			notice("dbg: ${run_prefix} ... ${name}")

  $pidfile="${run_prefix}/${name}.pid"
  $workdir="${cache_prefix}/${name}"
  $logdir="${log_prefix}/${name}"
  $appdir="${prefix}/${name}"
  $exec_jar="${appdir}/${name}.jar"

  if $ensure == 'present' {
    file { $prefix:
      ensure => directory,
    }  

    file { $workdir:
      ensure => directory,
      owner => $owner,
      group => $group,
    }

    file { $logdir:
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
      content => template("jvm/jetty.sh.erb"),
      notify => Service["${name}"],
      owner => root,
      group => root,
      mode   => '0755',
    }

    file { "/etc/sudoers.d/${owner}_${name}": 
      mode    => '0400',
      owner   => root,
      group   => root,
      content => "${owner}   ALL = (root) NOPASSWD: /usr/sbin/service ${name} *\n",
    }

    service { $name:
      enable    => true,
      hasstatus => true,
      require   => File["/etc/init.d/${name}"],
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

