class system {

    $tools       = [ 'molly-guard', 'logrotate', 'vim' ]
    $devPackages = [ 'curl', 'git', 'strace', 'sysstat' ]
    $sysPackages = [ 'build-essential', 'wget', 'bash-completion', 'ntp', 'ntpdate', 'unzip', 'bzip2', 'zip', 'samba', 'samba-common', 'smbclient', 'sendmail', 'python', 'python-pip', 'python-dev' ]


    package { $sysPackages:
        ensure => latest,
        require => Exec[ 'apt-get update' ],
    }


    package { $tools:
        ensure => latest,
        require => Exec[ 'apt-get update' ],
    }


    package { $devPackages:
        ensure => latest,
        require => Exec[ 'apt-get update' ],
    }

}
