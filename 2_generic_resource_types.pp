file { "/etc/timezone":
  content => "Europe/Oslo\n",
}

exec { "reconfigure-tzdata":
  command => "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata",
  before => File["/etc/timezone"], # Only for demo purposes
}
