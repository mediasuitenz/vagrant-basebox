class php5 {

  exec { "update package manager":
    command => "/usr/bin/apt-get update"
  }

  package { "php5":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php5-cli":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php5-mysql":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php5-curl":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "libapache2-mod-php5":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "memcached":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php5-memcache":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php-pear":
    ensure => present,
    require => Exec['update package manager'],
  }

  package { "php5-sqlite":
    ensure => present,
    require => Exec['update package manager'],
    notify => Service['apache2'],
  }

  package { "sqlite3":
    ensure => present,
    require => Exec['update package manager'],
    notify => Service['apache2'],
  }

}
