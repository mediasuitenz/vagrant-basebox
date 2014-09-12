# Class: bash
#
#
class bash {
    # On ssh login cd to /vagrant
    file { '/home/vagrant/.bash_login':
      ensure  => file,
      content => template("bash/bash_login_default"),
    }

    # Create a bash_profile file
    file { '/home/vagrant/.bash_profile':
      ensure  => file,
      content => template("bash/bash_profile_default"),
    }
    
}
