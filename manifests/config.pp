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
class rsyslog::config {

  file { 
    $rsyslog::rsyslog_d:
      ensure  => directory,
      owner   => 'root',
      group   => $rsyslog::run_group,
      purge   => $rsyslog::purge_rsyslog_d,
      recurse => true,
      force   => true;
    $rsyslog::global_work_dir:
      ensure  => directory,
      owner   => $rsyslog::run_user,
      group   => $rsyslog::run_group,
      seltype => 'syslogd_var_lib_t',
      notify  => Class['rsyslog::service'];
  }

  concat {
    $rsyslog::rsyslog_conf:
      owner   => 'root',
      group   => $rsyslog::run_group,
      mode    => '0640',
      notify  => Class['rsyslog::service'];
  }

  concat::fragment {
    "default_config_start":
      target => $rsyslog::rsyslog_conf,
      order  => '001',
      content => template('rsyslog/rsyslog.conf/_start.erb');
    "default_modules_start":
      target => $rsyslog::rsyslog_conf,
      order  => '010',
      content => template('rsyslog/rsyslog.conf/module_start.erb');
  }

  # Default to order => 20
  if ($rsyslog::default_modules == true) {
    create_resources('rsyslog::module', $rsyslog::params::default_modules)
  } else {
    create_resources('rsyslog::module', $rsyslog::modules)
  }

  concat::fragment {
    "default_config_global":
      target => $rsyslog::rsyslog_conf,
      order  => '100',
      content => template('rsyslog/rsyslog.conf/_global.erb');
  }

  # If main_queue is called it is inserted at order => 110

  concat::fragment {
    "default_config_end":
      target => $rsyslog::rsyslog_conf,
      order  => '999',
      content => template('rsyslog/rsyslog.conf/_end.erb');
  }

  $merged_default = merge($rsyslog::default_ruleset_actions, $rsyslog::default_ruleset_merge_actions)

  create_resources('rsyslog::ruleset', { '01_default' => { ruleset_name => 'DefaultRuleSet', ruleset_options => $merged_default } })
  if ($rsyslog::inputs != undef) {
    create_resources('rsyslog::input', $rsyslog::inputs)
  }

  if ($rsyslog::rulesets != undef) {
    create_resources('rsyslog::ruleset', $rsyslog::rulesets)
  }

}
