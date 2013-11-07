devbox Vagrant project
======================

These manifests create a virtual machine with my preferred development tools and server software.
ALL SETTINGS ARE NOT MEANT FOR PRODUCTION!!!
.oO( ok, except nginx and php-fpm confs.)

1) installed by default
-----------------------

    nginx
    php-fpm 5.4
    MariaDB
    MongoDB
    composer
    fabric

additionally, a user "wwwdev" is created, including basic nginx config and php-fpm pool.
also a samba share is configured - for details, see the "files" and "templates" folders in
the according modules.

2) stages
---------

Yes. I. Use. Stages.
to all puppeteers: in my case, stages made the most sense. if you have better ideas... I'm open to suggestions (forks!) ;-)

3) configuration
----------------

all authorized_key files are empty: fill with your own keys, please.
keep in mind to change the .gitconf file in users module, to remove my name and email address.
phpmyadmin and MariaDB have a root access (root:vagrant).
by default the nginx conf provides a /phpmyadmin route.
