class system_pre {

    File { owner => root, group => root, mode => 0644 }


    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }


    exec { 'apt-get update':
        command => 'apt-get update -y',
    }


    file { '/home/www':
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 755,
    }


    file { '/etc/apt/sources.list':
        ensure => file,
        source => "puppet:///modules/system_pre/sources.list",
    }


    file { '/home/vagrant/.bashrc':
        ensure => file,
        owner  => vagrant,
        group  => vagrant,
        source => "puppet:///modules/system_pre/.bashrc",
    }


    file { '/root/.ssh':
        ensure => directory,
        owner  => root,
        group  => root,
    }


    file { '/root/.ssh/root':
        ensure  => file,
        owner   => root,
        group   => root,
        source  => "puppet:///modules/system_pre/vagrant",
        require => File[ '/root/.ssh' ],
    }


    file { '/home/vagrant/.ssh/authorized_keys':
        ensure => file,
        owner  => vagrant,
        group  => vagrant,
        source => "puppet:///modules/system_pre/authorized_keys",
    }


    file { '/usr/bin/create_project':
        ensure => file,
        owner  => root,
        group  => root,
        mode   => 0755,
        source => "puppet:///modules/system_pre/create_project",
    }


    exec { 'import-gpg':
        command => "wget -q http://www.dotdeb.org/dotdeb.gpg -O -| apt-key add -"
    }


    exec { 'import-mirrors-pgp':
        #command => 'gpg --keyserver wwwkeys.us.pgp.net --recv-keys CBCB082A1BB943DB; gpg -a --export CBCB082A1BB943DB | apt-key add -;',
        command => 'gpg --keyserver pool.sks-keyservers.net --recv-keys CBCB082A1BB943DB; gpg -a --export CBCB082A1BB943DB | apt-key add -;',
    }


    exec { 'import-mariadb-pgp':
        command => 'apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db',
    }


    exec { '/usr/bin/apt-get update -y':
        require => [ File[ '/etc/apt/sources.list' ], Exec[ 'apt-get update' ], Exec[ 'import-gpg'], Exec[ 'import-mirrors-pgp' ], Exec[ 'import-mariadb-pgp' ] ],
    }


    group { 'puppet':
        ensure => 'present',
    }
    

    file { '/etc/motd':
        content => "\n ..coccccccccccccccccccccccccccccccccccccccccoc.. \n.:o                                            o:.\n.cc                   ..                       cc.\n.cc               :8@@@@@@@@@@8OC:             cc.\n.cc            :@@@@@8o      .oOO88C:          cc.\n.cc          .@@@8o              o8CCO.        cc.\n.cc       . :@@O                   o88@:       cc.\n.cc        C@O            ::.       CCc:       cc.\n.cc       c@8          Oo           :8C        cc.\n.cc       88.         8             .@O.       cc.\n.cc       8O         c.             :@C        cc.\n.cc       8C         :c        :    CO         cc.\n.cc       OO          oc    :      Cc          cc.\n.cc       C8:         :.oc      coo            :c.\n.cc        8C            c:::c:.               cc.\n.cc        :8Oo                                :c.\n.cc         :OO.                               cc.\n.cc           oO.                              :c.\n.cc            :Oo                             cc.\n.cc              .CC                           :c.\n.cc                 .oC:                       cc.\n.cc                                            cc.\n..cc                                          cc..\n  ..:cccccccccccccccccccccccccccccccccccccccc:..  \n\n\n           welcome to ${hostname}\n\n     this server is managed by puppet!\n\n     modules:\n     ----------\n          nginx\n          php-fpm 5.4\n          mariaDB 5.5\n          git\n          composer\n          fabric\n\n"
    }

}