class toolscripts {

    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }

    file { '/home/scripts':
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 755,
    }


    file { '/home/scripts/base_config':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/base_config",
        require => File[ '/home/scripts' ],
    }


    file { '/home/scripts/base_functions':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/base_functions",
        require => File[ '/home/scripts/base_config' ],
    }


    file { '/home/scripts/git_branch':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/git_branch",
        require => File[ '/home/scripts/base_functions' ],
    }


    file { '/home/scripts/git_merge':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/git_merge",
        require => File[ '/home/scripts/git_branch' ],
    }


    file { '/home/scripts/git_pull':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/git_pull",
        require => File[ '/home/scripts/git_merge' ],
    }


    file { '/home/scripts/ws_restart':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/ws_restart",
        require => File[ '/home/scripts/git_pull' ],
    }


    file { '/home/scripts/create_symlinks':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/create_symlinks",
        require => File[ '/home/scripts/ws_restart' ],
    }


    file { '/home/scripts/link_configs':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 755,
        source => "puppet:///modules/toolscripts/link_configs",
        require => File[ '/home/scripts/create_symlinks' ],
    }


    exec { 'symlinks':
        command => '/home/scripts/create_symlinks',
        require => File[ '/home/scripts/create_symlinks' ],
    }


    exec { 'pip-fabric':
        command => 'pip install --upgrade fabric',
    }

    file { '/usr/bin/fab':
        ensure => 'link',
        target => '/usr/local/bin/fab',
        require => Exec[ 'pip-fabric' ],
    }

}
