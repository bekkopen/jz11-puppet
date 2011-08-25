$port = 22
$allowed_users = ["root", "eivind", "oc", "www-mgr"] # Tillat innlogging

package { "openssh-server":
  ensure => present,
}

file { "/etc/ssh/sshd_config":
  content => template("sshd_config.erb"),
  require => Package["openssh-server"],
}

service { ssh:
  ensure    => running,
  hasstatus => true,
  subscribe => [Package["openssh-server"],
                File["/etc/ssh/sshd_config"]],
}