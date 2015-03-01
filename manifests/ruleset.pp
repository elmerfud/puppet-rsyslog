# == Class: rsyslog::ruleset
#

define rsyslog_rs::ruleset (
  $ruleset_name = undef,
  $ruleset_options = {},
) {

  concat {
    "${rsyslog_rs::rsyslog_d}/${name}.conf":
      owner => $rsyslog_rs::log_user,
      group => $rsyslog_rs::log_group,
      mode => $rsyslog_rs::umask;
  }

  concat::fragment {
    "rule_${name}_start":
      target => "${rsyslog_rs::rsyslog_d}/${name}.conf",
      order  => '001',
      content => "ruleset(name=\"${ruleset_name}\") {\n";
    "rule_${name}_end":
      target => "${rsyslog_rs::rsyslog_d}/${name}.conf",
      order  => '999',
      content => "}\n";
  }

  create_resources('rsyslog_rs::action', $ruleset_options, { 'ruleset_name' => $ruleset_name, 'fileconcat_name' => "${rsyslog_rs::rsyslog_d}/${name}.conf" } )

}
