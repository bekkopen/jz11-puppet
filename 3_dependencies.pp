file { "/etc/timezone":
  content => "Europe/Oslo\n",
}

exec { "reconfigure-tzdata":
  command => "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata",
  require => File["/etc/timezone"],
}
