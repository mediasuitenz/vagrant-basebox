class apache2 {

  package { 'python software properties':
    ensure => installed,
    name => "software-properties-common",
  }
  ->
  exec { 'add apache2 ppa':
    command => '/usr/bin/apt-add-repository ppa:ondrej/apache2',
  }
  ->
  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
  }
  ->
  package { "apache2":
    ensure => "2.4.10-1+deb.sury.org~trusty+1",
  }

  exec {"a2enmod ssl":
    command => "/usr/sbin/a2enmod ssl",
    require => Package["apache2"],
  }

  service { "apache2":
    ensure  => running,
    require => Package["apache2"],
  }

  exec {'enable apache2 rewriteEngine':
    command => '/usr/sbin/a2enmod rewrite',
    require => Package["apache2"],
    notify  => Service['apache2'],
  }

  file { "default":
    path    => "/etc/apache2/sites-available/default",
    ensure  => file,
    require => Package["apache2"],
    content => template("apache2/default"),
    notify  => Service["apache2"],
  }

  file { "default-ssl":
    path    => "/etc/apache2/sites-available/default-ssl",
    ensure  => file,
    require => Package["apache2"],
    content => template("apache2/default-ssl"),
  }
  ->
  file { "/etc/apache2/sites-enabled/default-ssl":
    target  => "/etc/apache2/sites-available/default-ssl",
    ensure  => 'link',
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  file { "project.dev.conf":
    path    => "/etc/apache2/sites-available/project.dev.conf",
    ensure  => file,
    require => Package["apache2"],
    content => template("apache2/project.dev.conf"),
  }
  ->
  file { "/etc/apache2/sites-enabled/project.dev.conf":
    target  => "/etc/apache2/sites-available/project.dev.conf",
    ensure  => 'link',
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  file { "project-ssl.dev.conf":
    path    => "/etc/apache2/sites-available/project-ssl.dev.conf",
    ensure  => file,
    require => Package["apache2"],
    content => template("apache2/project-ssl.dev.conf"),
  }
  ->
  file { "/etc/apache2/sites-enabled/project-ssl.dev.conf":
    target  => "/etc/apache2/sites-available/project-ssl.dev.conf",
    ensure  => 'link',
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
}
