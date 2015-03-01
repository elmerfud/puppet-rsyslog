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
class rsyslog_rs (
  $rsyslog_package_name   = $rsyslog_rs::params::rsyslog_package_name,
  $relp_package_name      = $rsyslog_rs::params::relp_package_name,
  $mysql_package_name     = $rsyslog_rs::params::mysql_package_name,
  $pgsql_package_name     = $rsyslog_rs::params::pgsql_package_name,
  $gnutls_package_name    = $rsyslog_rs::params::gnutls_package_name,
  $package_status         = $rsyslog_rs::params::package_status,
  $rsyslog_d              = $rsyslog_rs::params::rsyslog_d,
  $purge_rsyslog_d        = $rsyslog_rs::params::purge_rsyslog_d,
  $rsyslog_conf           = $rsyslog_rs::params::rsyslog_conf,
  $rsyslog_default_file   = $rsyslog_rs::params::default_config_file,
  $run_user               = $rsyslog_rs::params::run_user,
  $run_group              = $rsyslog_rs::params::run_group,
  $log_user               = $rsyslog_rs::params::log_user,
  $log_group              = $rsyslog_rs::params::log_group,
  $log_style              = $rsyslog_rs::params::log_style,
  $umask                  = $rsyslog_rs::params::umask,
  $perm_file              = $rsyslog_rs::params::perm_file,
  $perm_dir               = $rsyslog_rs::params::perm_dir,
  $spool_dir              = $rsyslog_rs::params::spool_dir,
  $service_name           = $rsyslog_rs::params::service_name,
  $service_hasrestart     = $rsyslog_rs::params::service_hasrestart,
  $service_hasstatus      = $rsyslog_rs::params::service_hasstatus,
  $preserve_fqdn          = $rsyslog_rs::params::preserve_fqdn,
  $max_message_size       = $rsyslog_rs::params::max_message_size,
  $main_queue              = $rsyslog_rs::params::main_queue,
  $default_modules         = $rsyslog_rs::params::default_modules,
  $default_ruleset_actions = $rsyslog_rs::params::default_ruleset_actions,
  $default_inputs          = $rsyslog_rs::params::default_inputs,
  $modules          = undef,
  $rulesets         = undef,
  $inputs           = undef,
  $ruleset_merge_actions    = {}
) inherits rsyslog_rs::params {

  class { 
    '::rsyslog_rs::config': 
      require => Class['::rsyslog_rs::package'],
      notify => Class['::rsyslog_rs::service']
  }
  class { '::rsyslog_rs::package': }
  class { '::rsyslog_rs::service': }

  anchor {
    'rsyslog_rs::begin':
      before => Class['::rsyslog_rs::package'],
      notify => Class['::rsyslog_rs::service'],
  }
  anchor {
    'rsyslog_rs::end':
      require => Class['::rsyslog_rs::service'],
  }
#  class { 'rsyslog_rs::install': }
#  class { 'rsyslog_rs::config': }

#  if $extra_modules != [] {
#    class { 'rsyslog_rs::modload': }
#  }

#  class { 'rsyslog_rs::service': }

}
