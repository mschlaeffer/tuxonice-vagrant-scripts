#!/bin/sh

for i in $*; do
    cd $i
    vagrant halt
    vagrant destroy -f
    vagrant box update
    vagrant up --provision
    vagrant ssh -c "sudo /vagrant/tuxonice-cycle.sh 10 100M"
    cd ..
done

