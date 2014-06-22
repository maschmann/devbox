class phpmyadmin {


    package { 'phpmyadmin':
        ensure => latest,
    }


    file { '/etc/phpmyadmin/config.inc.php':
        ensure => file,
        owner  => www-data,
        group  => www-data,
        source => "puppet:///modules/phpmyadmin/config.inc.php",
        require => Package[ 'phpmyadmin' ],
    }

}