define jvm::jetty($prefix="/var/apps",

app_name=demo
port=7001
secret=6dd98fc321319d26ca0f7b30a8e7691a
prefix=/srv/deploy/demo
export CONSTRETTO_TAGS=production
export java_args="-Djetty.port=${port} -Djetty.contextPath=${context_path} -Djetty.shutdownSecret=${shutdown_secret} -DCONSTRETTO_TAGS=${CONSTRETTO_TAGS}"

                   $port=7000,
                   $secret=,
                   $owner=undef,
                   $group=undef,
                   $mediaroot="",
                   $mediaprefix="",
                   $default_vhost=false,
                   $rewrite_missing_html_extension=false,
                   $upstreams=[],
                   $aliases=[]) {

  $absolute_mediaroot = inline_template("<%= File.expand_path(mediaroot, root) %>")

  if $ensure == 'present' {
    # Parent directory of root directory. /var/www for /var/www/blog
    $root_parent = inline_template("<%= root.match(%r!(.+)/.+!)[1] %>")

    if !defined(File[$root_parent]) {
      file { $root_parent:
        ensure => directory,
        owner => $owner,
        group => $group,
      }
    }

    file { $root:
      ensure => directory,
      owner => $owner,
      group => $group,
      require => File[$root_parent],
    }

  } elsif $ensure == 'absent' {

    file { $root:
      ensure => $ensure,
      owner => $owner,
      group => $group,
      recurse => true,
      purge => true,
      force => true,
    }
  }

  file {
    "/etc/nginx/sites-available/${name}.conf":
      ensure => $ensure,
      content => template("nginx/site.conf.erb"),
      require => [File[$root],
                  Package[nginx]],
      notify => Service[nginx];

    "/etc/nginx/sites-enabled/${name}.conf":
      ensure => $ensure ? {
        'present' => link,
        'absent' => $ensure,
      },
      target => $ensure ? {
        'present' => "/etc/nginx/sites-available/${name}.conf",
        'absent' => notlink,
      },
      require => File["/etc/nginx/sites-available/${name}.conf"],
      notify => Service[nginx];
  }
}
