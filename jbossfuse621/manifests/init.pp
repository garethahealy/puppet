class jbossfuse621::params {

    $puppet_modules_home    = "/opt/garethahealy/puppet/modules"
    $rh_home                = "/opt/rh"
    $user_username          = "jbossfuse"
    $enhancers              = [ 'curl', 'wget', 'zip', 'unzip', 'tar', 'vim', 'telnet', 'bc', 'git', 'java-1.8.0-openjdk', 'java-1.8.0-openjdk-devel' ]
}

class jbossfuse621 inherits jbossfuse621::params {

    package {
        $jbossfuse621::params::enhancers:,
        ensure => 'installed'
    }

    group { '$jbossfuse621::params::user_username':
        ensure  => present,
        name	=> 'jbossfuse'
    }

    user { '$jbossfuse621::params::user_username':
        ensure	    => present,
        name	    => "$jbossfuse621::params::user_username",
        gid	        => "$jbossfuse621::params::user_username",
        home        => "/home/$jbossfuse621::params::user_username",
        system      => true,
        managehome  => true,
        comment     => "JBoss Fuse user"
    }

    file { ["/home/$jbossfuse621::params::user_username"]:
        ensure => "directory",
        owner  => "$jbossfuse621::params::user_username",
        group  => "$jbossfuse621::params::user_username",
        mode   => "0700"
    }

    file { ["$jbossfuse621::params::rh_home"]:
        ensure => "directory",
        owner  => "$jbossfuse621::params::user_username",
        group  => "$jbossfuse621::params::user_username",
        mode   => "0755"
    }

    exec { "sh $jbossfuse621::params::puppet_modules_home/jbossfuse621/files/run.sh":
        path      => ["/usr/bin", "/bin"],
        user      => "$jbossfuse621::params::user_username",
        logoutput => "true"
    }
}

include jbossfuse621

