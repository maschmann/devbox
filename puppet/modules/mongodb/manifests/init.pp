class mongodb {

   Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }
   $mongodb = [
        'mongodb'
    ]

    package { $mongodb:
        ensure => latest,
    }

    exec { 'install phpmongo':
        command => 'pecl install mongo',
        creates => '/usr/lib/php5/20100525/mongo.so'
    }

    file { '/etc/php5/conf.d/mongodb.ini':
        owner   => root,
        group   => root,
        source  => "puppet:///modules/mongodb/mongodb.ini",
        ensure  => present,
        require => Package[ $mongodb ],
    }

}