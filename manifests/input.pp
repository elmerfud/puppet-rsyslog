# == Class: rsyslog::input
#

define rsyslog::input (
  $input_type = undef,
  $input_options = {},
) {
  concat::fragment {
    "input_${name}":
      target => $rsyslog::rsyslog_conf,
      order  => '30',
      content => template('rsyslog/input.erb');
  }

}

