# == Class: rsyslog::modload
#

define rsyslog_rs::module (
  $module_name = undef,
  $module_options = {},
) {
  concat::fragment { 
    "module_${name}":
      target => $rsyslog_rs::rsyslog_conf,
      order  => '05',
      content => template('rsyslog_rs/module.erb');
  }

}
