class { '::puppet':
  puppetmaster => 'puppetmaster.localdomain',
  show_diff    => true,
  listen       => true,
}
