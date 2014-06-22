stage { 'pre':          before  => Stage[ 'init' ] }
stage { 'init':         before  => Stage[ 'main' ] }
stage { 'post':         require => Stage[ 'main' ] }
stage { 'post_cleanup': require => Stage[ 'post' ] }


node default {

    # do the stages
    class {
        'pre':      stage => pre;
        'base':     stage => main;
        'system':   stage => init;
        'post':     stage => post;
        'cleanup':  stage => post_cleanup;
    }

    class pre {
        class { 'system_pre':  }
    }

    class base {

        class { 'mysql': }
        class { 'users': }
        class { 'nginx': }
        class { 'php': }


        users::resources::create { 'wwwdev_user':
            user    => 'wwwdev',
            group   => 'wwwdev',
            shell   => '/bin/bash',
            sudoers => true,
        }


        nginx::resources::createserver { 'wwwdev_server':
            domain    => 'dev.local',
            home      => '/home/www/wwwdev',
            user      => 'wwwdev',
            group     => 'wwwdev',
            fcgi_port => 9000,
            type      => 'sf2',
        }


        php::resources::createpool { 'wwwdev_pool':
            domain    => 'dev.local',
            name      => 'default',
            user      => 'wwwdev',
            group     => 'wwwdev',
            fcgi_port => 9000,
        }

    }


    class post {

        class { 'composer': }
        class { 'phpmyadmin': }
        class { 'toolscripts': }
        class { 'mongodb': }

        #composer::resources::createproject { 'wwwdev_fms':
        #    path    => '/home/www/wwwdev/dev.local/htdocs/fms',
        #    version => '2.1.7',
        #    user    => 'wwwdev',
        #    group   => 'wwwdev',
        #}


#        class { 'git': }

#        git::resources::clone { 'fms':
#            git_uri    => 'ssh://git@aschmann.org',
#            repository => 'fms',
#            user       => 'wwwdev',
#            dir        => '/home/www/wwwdev/dev.local/htdocs/fms',
#        }

    }

}
