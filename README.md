Instructions
------------

Some dependencies is required:

    apt-get install git-core puppet

You'll need to clone this repo and submodules:

    git clone git://github.com/bekkopen/jz11-puppet.git
    cd jz11-puppet
    git submodule update --init --recursive

Then invoke puppet:

    puppet apply --modulepath=modules demo.pp
