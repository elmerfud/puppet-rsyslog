# == Class: rsyslog::params
#
# This defines default configuration values for rsyslog.
# You don't want to use it directly.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'rsyslog::params': }
#
class rsyslog::params {

  $purge_rsyslog_d            = true
  $run_user = $::operatingsystem ? {
    'Ubuntu' => 'syslog',
    default  => 'root',
  }
  #$log_user = $::operatingsystem ? {
  #  'Ubuntu' => 'syslog',
  #  default  => 'root',
  #}
  $global_max_message_size    = undef
  $global_preserve_fqdn       = undef
  $main_queue                 = undef

  case $::osfamily {
    redhat: {
      if $::operatingsystem == 'Amazon' {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = false
        $default_config_file    = 'rsyslog_default'
      }
      elsif $::operatingsystemmajrelease == '5' {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default'
      }
      elsif $::operatingsystemmajrelease == '6' {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default'
      }
      elsif $::operatingsystemmajrelease >= '7' {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default_rhel7'
      } else {
        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystemmajrelease}.")
      }
      $package_status         = 'present'
      $rsyslog_d              = '/etc/rsyslog.d/'
      $rsyslog_conf           = '/etc/rsyslog.conf'
      $rsyslog_default        = '/etc/sysconfig/rsyslog'
      $run_group              = 'root'
      $global_work_dir        = '/var/lib/rsyslog'
      $service_name           = 'rsyslog'
      $ssl                    = false
      $service_hasrestart     = true
      $service_hasstatus      = true

      if versioncmp('7.0.0', $::rsyslog_version) > 0 {
        $default_modules = { 
          'imuxsock'      => {
            'mod_order'   => '021', 
            'mod_options' => undef
          },
          'imklog'        => {
            'mod_order'   => '022',
            'mod_options' => undef
          }
        }
      } else {
        $default_modules = {
          'imuxsock'   => {
            'mod_order' => '021', 
            'mod_options'              => {
              'SysSock.RateLimit.Interval' => '0',
              'SysSock.Use'                => 'off',
              'SysSock.Name'               => '/run/systemd/journal/syslog'
            }
          },
          'imjournal'   => {
            'mod_order' => '022',
            'mod_options' => {
              'StateFile'      => "$global_work_dir/imjournal.state" 
            }
          },
          'builtin:omfile' => {
            'mod_order'    => '023',
            'mod_options' => {
              'template'       => 'RSYSLOG_TraditionalFileFormat'
            }
          } 
        }
      }

      $default_ruleset_actions = {
        'default_action1'   => {
          'action_selector' => "*.info;mail.none;authpriv.none;cron.none",
          'action_output'   => '/var/log/messages',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '010'  
        },
        'default_action2'   => {
          'action_selector' => "authpriv.*",
          'action_output'   => '/var/log/secure',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '011'
        },
        'default_action3'   => {
          'action_selector' => "mail.*",
          'action_output'   => '/var/log/maillog',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '012'
        },
        'default_action4'   => {
          'action_selector' => "cron.*",
          'action_output'   => '/var/log/cron',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '013'
        },
        'default_action5'   => {
          'action_selector' => "*.emerg",
          'action_output'   => '*',
          'action_type'     => 'omusrmsg',
          'order'           => '014'
        },
        'default_action6'   => {
          'action_selector' => "uucp,news.crit",
          'action_output'   => '/var/log/spooler',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '015'
        },
        'default_action7'   => {
          'action_selector' => "local7.*",
          'action_output'   => '/var/log/boot.log',
          'action_template' => 'RSYSLOG_FileFormat',
          'action_type'     => 'omfile',
          'order'           => '016'
        }
      }
    }

    default: {
      fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
    }
  }   
}

