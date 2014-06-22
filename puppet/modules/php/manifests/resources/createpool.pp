define php::resources::createpool(
    $domain,
    $name,
    $user,
    $group,
    $fcgi_port,
    $ensure    = 'present'
) {


    require php


    $file_dir = '/etc/php5/fpm/pool.d/'


    file { "/var/log/php-fpm":
        owner   => root,
        group   => root,
        mode    => 0644,
        ensure  => directory,
    }


    file { "/var/log/php-fpm/slowlog-${domain}.log":
        owner   => root,
        group   => root,
        mode    => 0644,
        ensure  => file,
        require => File[ '/var/log/php-fpm' ],
    }


    file { "${file_dir}${name}.conf":
        ensure  => [ $ensure, file ],
        require => File[ "/var/log/php-fpm/slowlog-${domain}.log" ],
        content => template( "php/pool/pool.erb" )
    }


}