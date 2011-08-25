include nginx

$www_root = "/var/www/jz11"

file { $www_root:
  ensure => directory,
}

nginx::site { "jz11":
  domain => "jz11.muda.no",
  root => $www_root,
  upstreams => ["localhost:8080"],
}

Class["nginx"] -> File[$www_root] -> Nginx::Site["jz11"]

# Install Java
#package { "openjdk-6-jre":
#}

# TODO: install and configure Jetty
