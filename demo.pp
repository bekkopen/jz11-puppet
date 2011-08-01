include nginx

$www_root = "/var/www/jz11"

file { $www_root:
  ensure => directory,
}

nginx::site { "jz11":
  domain => "jz11.uggedal.com",
  root => $www_root,
  upstreams => ["localhost:8080"],
}

Class["nginx"] -> File[$www_root] -> Nginx::Site["jz11"]

# TODO: install and configure Jetty
