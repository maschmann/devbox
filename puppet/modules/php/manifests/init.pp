class php {

    require nginx

    $pkgPhp5Base = [
        "php5-cgi",
        "php5-fpm",
        "php5-common",
        "php5-cli"
    ]


    $phpRelated = [
        "php5-apc",
        "php5-curl",
        "php5-gd",
        "php5-imagick",
        "php5-mcrypt",
        "php5-memcached",
        "php5-mysql",
        "php5-xdebug",
        "php-pear",
		"php5-intl",
        "php5-dev",
        "mcrypt"
    ]


    package{ $pkgPhp5Base:
        ensure  => latest,
    }


    package { $phpRelated:
        ensure  => latest,
        require => Package[ $pkgPhp5Base ],
    }


    file { '/etc/php5/conf.d/custom.php.ini':
        owner   => root,
        group   => root,
        source  => "puppet:///modules/php/custom.php.ini",
        ensure  => present,
        require => Package[ $pkgPhp5Base ],
    }


    file { '/etc/php5/conf.d/custom.xdebug.ini':
        owner  => root,
        group  => root,
        source => "puppet:///modules/php/custom.xdebug.ini",
        ensure => present,
        require => Package[ $pkgPhp5Base ],
    }

}