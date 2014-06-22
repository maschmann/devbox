define nginx::resources::createserver(
    $domain,
    $home,
    $user,
    $group,
    $fcgi_port,
    $type      = ''
) {


    $template_home = "${home}/${domain}/htdocs"


    file { [ "${home}/${domain}",
             "${home}/${domain}/htdocs" ]:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => 755,
    }


    file { '/etc/nginx':
        ensure  => directory,
        owner   => root,
        group   => root,
    }


    file { '/etc/nginx/sites-enabled':
        ensure  => directory,
        owner   => root,
        group   => root,
        require => File[ '/etc/nginx' ],
    }


    file { "/etc/nginx/sites-enabled/${domain}.conf":
        ensure  => file,
        owner   => root,
        group   => root,
        content => template( "nginx/server/server${type}.erb" ),
        require => File[ '/etc/nginx/sites-enabled' ],
    }


}