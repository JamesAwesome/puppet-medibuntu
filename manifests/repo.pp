class medibuntu::repo {

  apt::source {'medibuntu':
    ensure      => present,
    location    => 'http://packages.medibuntu.org/',
    release     => $::lsbdistcodename,
    repos       => $::medibuntu::nonfree ? {
      false   => 'free',
      default => 'free non-free',
    },
    include_src => false,
  }

  # Medibuntu distributes their gpg key as a deb package.
  # Because of this we will not use apt::source to
  # add the repositories gpg key. That way the key will
  # be updated as the repository maintainer intends.
  # Lets force that to install and perform an apt-update
  # to refresh our sources. We must do this using exec
  # because if we tried to do so with the apt::update
  # class it would cause a dependency cycle.

  exec{'install_keyring':
    command     =>
      '/usr/bin/apt-get \
      install -q -y --allow-unauthenticated \
      medibuntu-keyring && \
      /usr/bin/apt-get -q -y update',
    refreshonly => true,
  }

  Apt::Source['medibuntu'] ~> Exec['install_keyring']

}
