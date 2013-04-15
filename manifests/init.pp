class medibuntu(
  $nonfree = true,
  $apport  = true,
) {

  # Distro has to be ubuntu.
  case $::operatingsystem {
    'Ubuntu': { }
    default:  {
      err('This module only supports the Ubuntu
        Gnu/Linux distribution')
    }
  }

  # If user wishes to install hooks for the
  # Ubuntu software center, do so. This is
  # done by default.
  case $apport {
    false:   { include medibuntu::repo
    }
    default: { include medibuntu::repo,
      medibuntu::apport
    }
  }

  Class['medibuntu::repo'] ->
    Class['medibuntu::packages']

}
