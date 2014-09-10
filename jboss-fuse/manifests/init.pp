# /etc/puppet/modules/jboss-fuse/manifests/init.pp

class jboss-fuse {

	$PUPPET_MODULES_HOME = "/etc/puppet/modules"
	
	$FUSE_FILENAME_ZIP = "jboss-fuse-full-6.1.0.redhat-379.zip"
	$FUSE_FILENAME = "jboss-fuse-6.1.0.redhat-379"
	$RH_HOME = "/opt/rh"

	$DEFAULT_FUSE_USERNAME = "admin"
	$DEFAULT_FUSE_PASSWORD = "admin"

	$USER_USERNAME = "jbossfuse"

	#Create fuse group
	group { "${USER_USERNAME}":
		ensure  => present,
  		name	=> "${USER_USERNAME}",
		system 	=> true
	}

	#Create fuse user
	user { "${USER_USERNAME}":
      		ensure	=> present,
		name	=> "${USER_USERNAME}",
      		gid     => "${USER_USERNAME}",
		system	=> true
    	}
	
	#Create root directory for JBoss-Fuse 
	file { ["${RH_HOME}"]:
		ensure => "directory",
        	owner  => "${USER_USERNAME}",
        	group  => "${USER_USERNAME}",
        	mode   => "0755"
	}

	#Install sshpass, which is used by the karaf install scripts
	package { "sshpass":
  		ensure  => installed
	}

	#Unzip fuse
	exec { "unzip ${PUPPET_MODULES_HOME}/jboss-fuse/files/${FUSE_FILENAME_ZIP}":
    		cwd 	=> "${RH_HOME}",
    		creates => "${RH_HOME}/${FUSE_FILENAME}/bin/fuse",
		path    => ["/usr/bin", "/usr/sbin"],
		user	=> "${USER_USERNAME}",
		logoutput => "true",
		onlyif	=> "/usr/bin/test -e ${PUPPET_MODULES_HOME}/jboss-fuse/files/${FUSE_FILENAME_ZIP}"
  	}

	#Append the default user
	file_line { "users.properties":
		ensure	=> present,
		path 	=> "${RH_HOME}/${FUSE_FILENAME}/etc/users.properties",
		line 	=> "\n${DEFAULT_FUSE_USERNAME}=${DEFAULT_FUSE_PASSWORD},admin",
		require	=> Exec["unzip ${PUPPET_MODULES_HOME}/jboss-fuse/files/${FUSE_FILENAME_ZIP}"]
	}
}
