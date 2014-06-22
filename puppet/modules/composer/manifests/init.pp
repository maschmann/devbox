class composer {

    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }


    exec { 'get-composer':
        command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/bin;',
        creates => '/usr/bin/composer.phar',
    }

}