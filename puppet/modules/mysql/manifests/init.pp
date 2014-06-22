class mysql {

    $password = 'vagrant'

    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }

    $mysql = [
        'python-software-properties',
        'mariadb-server',
        #'mariadb-server-5.5',
        #'mariadb-client-5.5',
        #'mariadb-server-core-5.5',
        'mariadb-common',
        'mysql-common',
    ]

    package { $mysql:
        ensure => latest,
    }


#    package { 'libmariadbclient18':
#        ensure => '5.5.29-mariadb1~squeeze',
#        require => Package[ 'libmysqlclient18' ],
#    }


#    package { 'libmysqlclient18':
#        ensure => '5.5.29-mariadb1~squeeze',
#    }

    exec { 'Set MySQL server root password':
        #subscribe   => [ Package[ 'mariadb-server' ], Package[ 'mariadb-client-5.5' ] ],
        subscribe   => Package[ 'mariadb-server' ],
        refreshonly => true,
        unless      => "mysqladmin -uroot -p$password status",
        path        => '/bin:/usr/bin',
        command     => "mysqladmin -uroot password $password",
    }
}