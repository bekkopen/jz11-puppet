group { "staff":
  ensure => present,
  gid    => 10,
}

user { "oc":
  ensure => present,
  gid    => 10,
  uid    => 1337,
  home   => "/home/oc",
}

cron { "poor-mans-http-ping":
  command => "curl -s http://demo.muda.no/ > /dev/null 2>&1",
  user    => "oc",
  minute  => "*/1", # Sjekk hvert minutt
}
