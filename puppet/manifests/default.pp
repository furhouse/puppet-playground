class { '::puppet':
  server                => true,
  server_foreman        => false,
  server_reports        => 'store',
  server_external_nodes => '',
  server_environments   => [],
}
class { '::hiera':
  datadir   => '/etc/puppet/hieradata/%{environment}/hieradata',
  hierarchy => [
    'nodes/%{::fqdn}',
    'common',
    ],
}
class { '::r10k':
  version           => '1.5.1',
  sources           => {
    'puppet' => {
      'remote'  => 'https://github.com/furhouse/500k-puppetcontrol.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    },
    'hiera'  => {
      'remote'  => 'https://github.com/furhouse/500k-hiera.git',
      'basedir' => "${::settings::confdir}/hieradata",
      'prefix'  => false,
    }
  },
  manage_modulepath => false,
}

# Class['::puppet'] -> Class['::hiera'] -> Class['::r10k']
