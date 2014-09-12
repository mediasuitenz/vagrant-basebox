# Class: bash
#
#
class bash {

    # Create a bash_profile file
    file { '/home/vagrant/.bash_profile':
      ensure  => file,
      content => template("bash/bash_profile_default"),
      owner   => 'vagrant',
      group   => 'vagrant',
    }
    
}
