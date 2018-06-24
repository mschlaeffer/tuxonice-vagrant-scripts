#!/bin/sh

for i in $*; do
    export UBUNTU=$i
    # cleanup
    vagrant halt
    vagrant destroy -f
    # setup
    vagrant box update
    vagrant up --provision
    # test
    time vagrant ssh -c "sudo /vagrant/tuxonice-cycle.sh 10 100M"
    echo
    # shutdown
    vagrant halt
done
