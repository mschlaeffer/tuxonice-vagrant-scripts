#!/bin/sh

for i in $*; do
    # cleanup
    vagrant halt
    vagrant destroy -f
    # setup
    sed -i "s|'s/trusty/.*/'|'s/trusty/$i/'|" tuxonice-install.sh
    vagrant box update
    vagrant up --provision
    # test
    time vagrant ssh -c "sudo /vagrant/tuxonice-cycle.sh 10 100M"
    echo
    # shutdown
    vagrant halt
done

