# == Class: rsyslog::action
#

define rsyslog::action (
  $action_selector = undef,
  $action_output = undef,
  $action_template = undef,
  $action_type = undef,
  $action_discard = false,
  $action_options = {},
  $action_if = undef,
  $action_then = undef,
  $order = '15',
  $ruleset_name = undef,
  $fileconcat_name = $rsyslog::rsyslog_conf
) {

  concat::fragment {
    "${ruleset_name}_${name}":
      target => $fileconcat_name,
      order  => $order,
      content => template('rsyslog/action.erb');
  }

}

