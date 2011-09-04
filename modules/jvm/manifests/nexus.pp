class jvm::nexus($version = "1.9.2.2",
				 $prefix  = "/opt",
				 $arch    = "linux-x86-32") {

  $target  = "nexus-oss-webapp-${version}"
  $dist_url= "http://nexus.sonatype.org/downloads/nexus-oss-webapp-${version}-bundle.tar.gz"
				
  file {$prefix:
	ensure => directory,
  }

  file { "${prefix}/${target}":
    require => Exec["Fetch and extract nexus"],
  }

  exec { "Fetch and extract nexus":
    cwd     => "${prefix}",
    command => "curl ${dist_url} | tar xz ",
    creates => "${prefix}/${target}",
    path    => ["/usr/bin", "/bin"],
  }

  file { "${prefix}/nexus":
    ensure  => link,
    target  => "${prefix}/${target}",
    require => File["${prefix}/${target}"],
  }

  file { "/etc/init.d/nexus":
    ensure  => link,
    target  => "${prefix}/nexus/bin/jsw/${arch}/nexus",
    require => File["${prefix}/nexus"],
  }

  service { 'nexus': 
	enable  => true,
	ensure  => running, 
    require => File['/etc/init.d/nexus'],
	subscribe => Exec["Fetch and extract nexus"],
  }

}

include jvm::nexus
Jvm::Jdk -> Jvm::Nexus
