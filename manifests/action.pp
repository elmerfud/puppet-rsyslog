# == Class: rsyslog::action
#

define rsyslog_rs::action (
  $action_type = undef,
  $action_options = {},
  $action_if = undef,
  $order = '15',
  $ruleset_name = undef,
  $fileconcat_name = $rsyslog_rs::rsyslog_conf
) {

  concat::fragment {
    "${ruleset_name}_${name}":
      target => $fileconcat_name,
      order  => $order,
      content => template('rsyslog_rs/action.erb');
  }

}

