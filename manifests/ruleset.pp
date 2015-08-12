# == Class: rsyslog::ruleset
#

define rsyslog::ruleset (
  $ruleset_name = undef,
  $ruleset_options = {},
) {

  concat {
    "${rsyslog::rsyslog_d}/${name}.conf":
      owner => $rsyslog::log_user,
      group => $rsyslog::log_group,
      mode => $rsyslog::umask;
  }

  concat::fragment {
    "rule_${name}_start":
      target  => "${rsyslog::rsyslog_d}/${name}.conf",
      order   => '001',
      content => template('rsyslog/ruleset_start.erb');
    "rule_${name}_end":
      target  => "${rsyslog::rsyslog_d}/${name}.conf",
      order   => '999',
      content => template('rsyslog/ruleset_end.erb');
  }

  create_resources('rsyslog::action', $ruleset_options, { 'ruleset_name' => $ruleset_name, 'fileconcat_name' => "${rsyslog::rsyslog_d}/${name}.conf" } )

}
