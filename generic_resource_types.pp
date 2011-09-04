file { "/etc/timezone":
  content => "Europe/Oslo\n",
}

exec { "reconfigure-tzdata":
  command => "dpkg-reconfigure -f noninteractive tzdata",
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}
