user { "oc":
  ensure     => present,
  uid        => 1337,
  home       => "/home/oc",
  managehome => "/home/oc",
  password   => '$6$xSZZx34H$7Wv2cIRg/MP2BGGp64OOmjxL6vxfl2QxNsmsRylxWsyA4maIp20lot3rw76Bl75DXfqltqDQUwNNWmHSTlEuJ/',
}

cron { "poor-mans-http-ping":
  command => "curl -s http://demo.muda.no/ > /dev/null 2>&1",
  minute  => "*/1", # Sjekk hvert minutt
}
