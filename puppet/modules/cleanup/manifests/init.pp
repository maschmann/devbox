class cleanup {

    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }


    exec { "restart-samba":
        command => "/etc/init.d/samba restart",
    }


    exec { "restart-nginx":
        command => "/etc/init.d/nginx restart",
    }


    exec { "restart-php":
        command => "/etc/init.d/php5-fpm restart",
        require => File[ '/etc/php5/fpm/pool.d/www.conf' ],
    }


    file { '/etc/php5/fpm/pool.d/www.conf':
        ensure  => absent,
    }


    exec { 'upgrade-all':
        command => 'apt-get -y dist-upgrade',
    }

    exec { 'apt-get-remove':
        command => 'apt-get autoclean; apt-get autoremove --purge -y;',
	require => Exec[ 'upgrade-all' ],
    }

}
