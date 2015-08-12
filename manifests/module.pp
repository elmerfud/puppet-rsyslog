# == Class: rsyslog::modload
#

define rsyslog::module (
  $mod_name = $name,
  $mod_order = '020',
  $mod_options = {},
) {

  concat::fragment { 
    "module_${name}":
      target => $rsyslog::rsyslog_conf,
      order  => $mod_order,
      content => template('rsyslog/rsyslog.conf/module.erb');
  }

}
