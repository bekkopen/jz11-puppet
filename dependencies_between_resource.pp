file { "/etc/timezone":
  content => "Europe/Oslo\n",
}

exec { "reconfigure-tzdata":
  command => "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata",
  subscribe => File["/etc/timezone"],
  require => File["/etc/timezone"],
  refreshonly => true,
}
