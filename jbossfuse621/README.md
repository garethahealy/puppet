# jbossfuse621
Install JBoss Fuse 6.2.1 (http://www.jboss.org/products/fuse/overview/)

## Example commands
- sudo /opt/puppetlabs/bin/puppet apply --noop /opt/garethahealy/puppet/modules/jbossfuse621/manifests/init.pp
- sudo /opt/puppetlabs/bin/puppet apply /opt/garethahealy/puppet/modules/jbossfuse621/manifests/init.pp

## Why do i need to mvn clean install?
The puppet module expects to find any pre-req files in the 'files' directory
