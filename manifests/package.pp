# == Class: rsyslog::package
#
# This class makes sure that the required packages are installed
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'rsyslog::package': }
#
class rsyslog_rs::package {
  if $rsyslog_rs::rsyslog_package_name != false {
    package { $rsyslog_rs::rsyslog_package_name:
      ensure => $rsyslog_rs::package_status,
    }
  }

  if $rsyslog_rs::relp_package_name != false {
    package { $rsyslog_rs::relp_package_name:
      ensure => $rsyslog_rs::package_status
    }
  }

  if $rsyslog_rs::gnutls_package_name != false {
    package { $rsyslog_rs::gnutls_package_name:
      ensure => $rsyslog_rs::package_status
    }
  }

}
