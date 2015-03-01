# == Class: rsyslog::config
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'rsyslog::config': }
#
class rsyslog_rs::config {

  file { 
    $rsyslog_rs::rsyslog_d:
      ensure  => directory,
      owner   => 'root',
      group   => $rsyslog_rs::run_group,
      purge   => $rsyslog_rs::purge_rsyslog_d,
      recurse => true,
      force   => true,
      require => Class['rsyslog_rs::package'];
    $rsyslog_rs::spool_dir:
      ensure  => directory,
      owner   => $rsyslog_rs::run_user,
      group   => $rsyslog_rs::run_group,
      seltype => 'syslogd_var_lib_t',
      require => Class['rsyslog_rs::package'],
      notify  => Class['rsyslog_rs::service'];
  }

  concat {
    $rsyslog_rs::rsyslog_conf:
      owner   => 'root',
      group   => $rsyslog_rs::run_group,
      mode    => '0640',
      require => Class['rsyslog_rs::package'],
      notify  => Class['rsyslog_rs::service'];
  }

  concat::fragment {
    "default_config":
      target => $rsyslog_rs::rsyslog_conf,
      order  => '20',
      content => template('rsyslog_rs/rsyslog.conf.erb');
  }

  $merged_default = merge($rsyslog_rs::default_ruleset_actions, $rsyslog_rs::ruleset_merge_actions)

  if ($rsyslog_rs::default_inputs != undef) {
    create_resources('rsyslog_rs::input', $rsyslog_rs::default_inputs)
  }
  create_resources('rsyslog_rs::module', $rsyslog_rs::default_modules)
  create_resources('rsyslog_rs::ruleset', { '01_default' => { ruleset_name => 'DefaultRuleSet', ruleset_options => $merged_default } })
  if ($rsyslog_rs::inputs != undef) {
    create_resources('rsyslog_rs::input', $rsyslog_rs::inputs)
  }
  if ($rsyslog_rs::modules != undef) {
    create_resources('rsyslog_rs::module', $rsyslog_rs::modules)
  }
  if ($rsyslog_rs::rulesets != undef) {
    create_resources('rsyslog_rs::ruleset', $rsyslog_rs::rulesets)
  }

}
