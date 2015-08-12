# == Class: rsyslog
#
# Meta class to install rsyslog with a basic configuration.
# You probably want rsyslog::client or rsyslog::server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'rsyslog': }
#
class rsyslog (
  $rsyslog_package_name    = $rsyslog::params::rsyslog_package_name,
  $relp_package_name       = $rsyslog::params::relp_package_name,
  $mysql_package_name      = $rsyslog::params::mysql_package_name,
  $pgsql_package_name      = $rsyslog::params::pgsql_package_name,
  $gnutls_package_name     = $rsyslog::params::gnutls_package_name,
  $package_status          = $rsyslog::params::package_status,
  $rsyslog_d               = $rsyslog::params::rsyslog_d,
  $purge_rsyslog_d         = $rsyslog::params::purge_rsyslog_d,
  $rsyslog_conf            = $rsyslog::params::rsyslog_conf,
  $rsyslog_default_file    = $rsyslog::params::default_config_file,
  $run_user                = $rsyslog::params::run_user,
  $run_group               = $rsyslog::params::run_group,
  $log_user                = $rsyslog::params::log_user,
  $log_group               = $rsyslog::params::log_group,
  $log_style               = $rsyslog::params::log_style,
  $umask                   = $rsyslog::params::umask,
  $perm_file               = $rsyslog::params::perm_file,
  $perm_dir                = $rsyslog::params::perm_dir,
  $global_work_dir         = $rsyslog::params::global_work_dir,
  $global_preserve_fqdn    = $rsyslog::params::global_preserve_fqdn,
  $global_max_message_size = $rsyslog::params::global_max_message_size,
  $global_additional_opts  = undef,
  $service_name            = $rsyslog::params::service_name,
  $service_hasrestart      = $rsyslog::params::service_hasrestart,
  $service_hasstatus       = $rsyslog::params::service_hasstatus,
  $main_queue              = $rsyslog::params::main_queue,
  $default_ruleset_actions = $rsyslog::params::default_ruleset_actions,
  $default_inputs          = $rsyslog::params::default_inputs,
  $modules                 = $rsyslog::params::default_modules,
  $rulesets                = undef,
  $inputs                  = undef,
  $default_modules         = true,
  $default_ruleset_merge_actions   = {}
) inherits rsyslog::params {

  class { '::rsyslog::package': }->
  class { '::rsyslog::config': }~>
  class { '::rsyslog::service': }

#  anchor {
#    'rsyslog_rs::begin':
#      before => Class['::rsyslog_rs::package'],
#      notify => Class['::rsyslog_rs::service'],
#  }
#  anchor {
#    'rsyslog_rs::end':
#      require => Class['::rsyslog_rs::service'],
#  }
#  class { 'rsyslog_rs::install': }
#  class { 'rsyslog_rs::config': }

#  if $extra_modules != [] {
#    class { 'rsyslog_rs::modload': }
#  }

#  class { 'rsyslog_rs::service': }

}
