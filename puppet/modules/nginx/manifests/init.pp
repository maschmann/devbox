class nginx {

    $nginxPackages = [
        "nginx",
        "nginx-full",
        "nginx-common",
        "nginx-extras"
    ]


    file { '/etc/nginx/sites-enabled/default':
        ensure  => purged,
        require => Package[ $nginxPackages ],
    }


    package { $nginxPackages:
        ensure  => latest,
    }

}