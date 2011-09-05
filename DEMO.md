DEMO
====

# @mgmt
export NEWHOSTNAME=mgmt.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/master.sh)

puppet agent --test

# @app1
export NEWHOSTNAME=app1.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/agent.sh)

java -version
puppet agent --test

# @mgmt
puppet cert -s app1.muda.no

java -version
ps ax | grep [p]ost

# @dev:
make

# @web1
export NEWHOSTNAME=web1.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/agent.sh)

curl -vvv http://localhost

# @mgmt
puppet cert -s web1.muda.no

puppet agent --test
curl -vvv http://localhost
ps ax | grep [n]ginx

