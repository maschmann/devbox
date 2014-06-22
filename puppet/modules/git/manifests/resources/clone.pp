class git::resources::clone(
    $git_uri,
    $repository,
    $user,
    $dir
){

    exec { "clone_${repository}":
        command => "git clone ${git_uri}/${repo} ${dir}/${repo}; exit; chown -R ${user}:${user} ${dir}/${repo}"
    }

}