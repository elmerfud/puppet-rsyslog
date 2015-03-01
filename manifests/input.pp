# == Class: rsyslog::input
#

define rsyslog_rs::input (
  $input_type = undef,
  $input_options = {},
) {
  concat::fragment {
    "input_${name}":
      target => $rsyslog_rs::rsyslog_conf,
      order  => '30',
      content => template('rsyslog_rs/input.erb');
  }

}

