class nfs::server::ubuntu::install {

  package { 'nfs-kernel-server':
    ensure => installed
  }

}
