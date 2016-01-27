#!/usr/bin/env bash

cp /opt/garethahealy/puppet/modules/jbossfuse621/files/jboss-fuse-full-6.2.1.redhat-084.zip /opt/rh/jboss-fuse-full-6.2.1.redhat-084.zip
cp /opt/garethahealy/puppet/modules/jbossfuse621/files/scaffolding-scripts-1.0.4-all.zip /tmp/scaffolding-scripts-1.0.4-all.zip

cd /tmp &&
    unzip -o scaffolding-scripts-*-all.zip &&
    cd scripts &&
    chmod -R 755 install-fuse.sh &&
    ./install-fuse.sh -e vagrant-child
