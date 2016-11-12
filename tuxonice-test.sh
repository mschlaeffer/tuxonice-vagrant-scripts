#!/bin/sh

for i in $*; do
    mkdir -p $i
    cd $i

    # cleanup
    vagrant halt
    vagrant destroy -f
    rm -f Vagrantfile tuxonice-install.sh tuxonice-grub.sh tuxonice-cycle.sh

    # setup
    cp -f ../Vagrantfile ../tuxonice-install.sh ../tuxonice-grub.sh ../tuxonice-cycle.sh .
    vagrant box update
    vagrant up --provision

    # test
    time vagrant ssh -c "sudo /vagrant/tuxonice-cycle.sh 10 100M"
    echo

    # cleanup
    vagrant halt
    vagrant destroy -f
    rm -f Vagrantfile tuxonice-install.sh tuxonice-grub.sh tuxonice-cycle.sh

    cd ..
done

