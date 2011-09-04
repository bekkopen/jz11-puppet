node 'web1.muda.no' {
  include nginx

  $www_root = "/var/www/demo"

  file { $www_root:
    ensure => directory,
  }

  nginx::site { "demo":
    domain => "www.muda.no",
    root => $www_root,
    upstreams => ["app1.muda.no:9000"],
  }

  Class["nginx"] -> File[$www_root] -> Nginx::Site["demo"]
}

node 'app1.muda.no' {

  include postgresql::server

  postgresql::database { "demo":
    owner => "demo",
  }

  package { "openjdk-6-jre":
    ensure => present,
  }

  # TODO: install and configure Jetty
}


