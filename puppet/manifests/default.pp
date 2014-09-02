# -dev version required for librarian-puppet dependencies
class { 'ruby':
  ruby_package     => 'ruby1.9.1-dev',
  rubygems_package => 'rubygems1.9.1',
  gems_version     => 'latest',
}

# Puppet tools
package { 'librarian-puppet':
  ensure   => 'installed',
  provider => 'gem',
  require  => Class['ruby'],
}

# Version control
include git

# Editors
package { "vim":
  ensure => present,
}

package { "curl":
  ensure => present,
}

file {'/var/www/vhosts':
  ensure => 'directory'
}

include apache2
include php5
include composer

# module installed via
# https://forge.puppetlabs.com/fsalum/redis
# with the commands
# v ssh
# puppet module install --modulepath /vagrant/puppet/modules fsalum/redis
class { 'redis': }

# Database
class {'mysql::server':
  root_password => 'password',
  override_options => {
    mysqld => {
      bind_address => '0.0.0.0',
      "skip-external-locking" => "false",
    }
  }
}
->
mysql_user { 'user@localhost':
  ensure                   => 'present',
  max_connections_per_hour => '0',
  max_queries_per_hour     => '0',
  max_updates_per_hour     => '0',
  max_user_connections     => '0',
  password_hash            => '*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19',
}
->
mysql_grant { 'user@localhost/*.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'user@localhost',
}
->
mysql_grant { 'user@%/*.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'user@%',
}

mysql::db { 'development':
  user     => 'user',
  password => 'password',
  host     => '%',
  grant    => ['ALL'],
}

mysql::db { 'production':
  user     => 'user',
  password => 'password',
  host     => '%',
  grant    => ['ALL'],
}

mysql::db { 'testing':
  user     => 'user',
  password => 'password',
  host     => '%',
  grant    => ['ALL'],
}

# Install nodejs
class { 'nodejs':
  version => 'v0.10.31'
}
->
exec { 'add nodemodules to path':
  command => '/bin/bash -c \'echo "export PATH=$PATH:/usr/local/node/node-v0.10.31/bin" >> /home/vagrant/.bashrc\'',
}
exec { 'chown local dir':
  command => '/bin/chown -R vagrant /usr/local',
}

# Java
class { 'java':
  distribution => 'jre'
}

# On ssh login cd to /vagrant
file { '/home/vagrant/.bash_login':
  ensure  => 'file',
  path    => '/home/vagrant/.bash_login',
  content => "cd /vagrant\n",
  owner   => 'vagrant',
  group   => 'vagrant'
}
