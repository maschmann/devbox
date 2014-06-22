define composer::resources::createproject(
    $path,
    $version,
    $user,
    $group
) {

    Exec {
        path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11',
        logoutput => on_failure
    }


    exec { $path:
        command => "/usr/bin/create_project $path $version",
    }

    exec { "${path}_chown":
        command => "chown -R ${user}:${group} ${path}",
        require => Exec[ $path ],
    }

}