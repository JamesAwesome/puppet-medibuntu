class medibuntu::apport {

  if $::lsbdistrelease =~ /^(9\.10|[1-9][0-9]\.[0-9]+)$/ {
    package {['app-install-data-medibuntu',
      'apport-hooks-medibuntu']:
      ensure => latest,
    }
  } else {
    notice('Apport hooks are not available
      for this version of Ubuntu.')
  }

}
