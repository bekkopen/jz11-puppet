user { "oc":
  ensure => present,
  uid    => 1337,
  home   => "/home/oc",
}

cron { "poor-mans-http-ping":
  command => "curl -s http://demo.muda.no/ > /dev/null 2>&1",
  minute  => "*/1", # Sjekk hvert minutt
}
