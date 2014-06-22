define users::resources::create(
    $user,
    $group,
    $shell,
    $sudoers
) {

    group { $group:
        ensure => present,
    }


    user { $user:
        ensure     => present,
        home       => "/home/www/${user}",
        managehome =>  true,
        shell      => $shell,
        gid        => $group,
        groups     => [ 'admin' ],
        require    => Group[ $group ],
    }


    file { "/home/www/${user}":
        ensure  =>  directory,
        owner   =>  $user,
        group   =>  $user,
        mode    =>  0755,
        require =>  User[ $user ],
    }


    file { "/home/www/${user}/.bashrc":
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        source  => "puppet:///modules/users/.bashrc",
        require => User[ $user ],
    }


    file { "/home/www/${user}/.gitconfig":
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        source  => "puppet:///modules/users/.gitconfig",
        require => User[ $user ],
    }


    file { "/home/www/${user}/.vimrc":
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        source  => "puppet:///modules/users/.vimrc",
        require => User[ $user ],
    }


    file { "/home/www/${user}/.ssh":
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        require => User[ $user ],
    }


    file { "/home/www/${user}/.ssh/authorized_keys":
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        source  => "puppet:///modules/users/authorized_keys",
        require => File[ "/home/www/${user}/.ssh" ],
    }


    file { "/home/www/${user}/.ssh/config":
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    =>  0644,
        source  => "puppet:///modules/users/ssh_config",
        require => File[ "/home/www/${user}/.ssh" ],
    }


    file { '/etc/samba/smb.conf':
        ensure  => file,
        owner   => root,
        group   => root,
        source  => "puppet:///modules/users/smb.conf",
    }

}