PREP
====

# @mgmt
export NEWHOSTNAME=mgmt.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/master.sh)
cat << EOF >> .bashrc
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
EOF

# @app1
export NEWHOSTNAME=app1.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/agent.sh)
cat << EOF >> .bashrc
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
EOF

# @web1
export NEWHOSTNAME=web1.muda.no
bash < <(curl -s https://raw.github.com/bekkopen/jz11-puppet/master/init/agent.sh)
cat << EOF >> .bashrc
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
EOF

DEMO
====

# @mgmt
puppet agent --test

# @app1
java -version
puppet agent --test

# @mgmt
puppet cert -s app1.muda.no

# @app1
java -version
ps ax | grep [p]ost

# @dev
make

curl -vvv http://localhost

# @mgmt
puppet cert -s web1.muda.no

puppet agent --test
curl -vvv http://localhost
ps ax | grep [n]ginx

