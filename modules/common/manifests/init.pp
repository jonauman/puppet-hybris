class common {
  case $osfamily {

    'RedHat': {
      $packages = [
        "curl",
        "lsof",
        "gcc-c++",
        "python-pip",
        "python-simplejson",
        "ruby19-devel",
        "ruby-devel",
        "rubygems",
        "screen",
        "sysstat",
        "vim-enhanced"
      ] 
    }


    'Debian': {
      $packages = [
        "curl",
        "host",
        "lsof",
        "python-pip", 
        "python-simplejson",
        "ruby1.9.1-dev",
        "rubygems",
        "screen", 
        "sysstat",
        "vim"
      ]
    }
  }

  package { $packages: ensure => installed }

  include aws
  include common::account
}
