# == Class: rsyslog::service
#
# This class enforces running of the rsyslog service.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'rsyslog::service': }
#
class rsyslog_rs::service {
  service { $rsyslog_rs::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => $rsyslog_rs::service_hasstatus,
    hasrestart => $rsyslog_rs::service_hasrestart,
  }
}
