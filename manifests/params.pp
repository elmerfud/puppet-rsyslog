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
class rsyslog_rs::params {

  $max_message_size           = '2k'
  $purge_rsyslog_d            = true
  $default_modules = {
    'default_imuxsock' => {
      module_name => 'imuxsock',
      module_options => { 'SysSock.RateLimit.Interval' => '0' }
    },
    'default_imklog' => {
      module_name => 'imklog'
    },
  }
  $run_user = $::operatingsystem ? {
    'Ubuntu' => 'syslog',
    default  => 'root',
  }
  $log_user = $::operatingsystem ? {
    'Ubuntu' => 'syslog',
    default  => 'root',
  }
  $preserve_fqdn = false

  case $::osfamily {
    debian: {
      case $::operatingsystem {
        'Debian': {
          $run_group = 'root'
        }
        'Ubuntu': {
          $run_group = 'syslog'
        }
      }
      $rsyslog_package_name   = 'rsyslog'
      $relp_package_name      = 'rsyslog-relp'
      $mysql_package_name     = 'rsyslog-mysql'
      $pgsql_package_name     = 'rsyslog-pgsql'
      $gnutls_package_name    = 'rsyslog-gnutls'
      $package_status         = 'latest'
      $rsyslog_d              = '/etc/rsyslog.d/'
      $rsyslog_conf           = '/etc/rsyslog.conf'
      $rsyslog_default        = '/etc/default/rsyslog'
      $default_config_file    = 'rsyslog_default'
      $log_group              = 'adm'
      $log_style              = 'debian'
      $umask                  = '0000'
      $perm_file              = '0640'
      $perm_dir               = '0755'
      $spool_dir              = '/var/spool/rsyslog'
      $service_name           = 'rsyslog'
      $client_conf            = 'client'
      $server_conf            = 'server'
      $ssl                    = false
      $service_hasrestart     = true
      $service_hasstatus      = true
      $default_inputs         = undef
      $main_queue = {
        'queue.filename' => 'main',
        'queue.spoolDirectory' => $spool_dir,
        'queue.maxdiskspace' => '1g',
        'queue.timeoutenqueue' => '0',
        'queue.type' => 'LinkedList',
        'queue.saveonshutdown' => 'on'
      }
      $default_ruleset_actions = {
        'action1' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/syslog', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("*.*;auth,authpriv.none")',
          'order' => '010'
        },
        'action2' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/auth.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("auth,authpriv.*")',
          'order' => '011'
        },
        'action3' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/cron.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("cron.*")',
          'order' => '012'
        },
        'action4' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/daemon.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("daemon.*")',
          'order' => '013'
        },
        'action5' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/kern.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("kern.*")',
          'order' => '014'
        },
        'action6' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/mail.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("mail.*")',
          'order' => '015'
        },
        'action7' => {
          'action_type' => 'omfile',
          'action_options' => { 'file' => '/var/log/user.log', 'template' => 'RSYSLOG_FileFormat' },
          'action_if' => 'prifilt("user.*")',
          'order' => '016'
        }

      }
    }
    redhat: {
      if $::operatingsystem == 'Amazon' {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = false
        $default_config_file    = 'rsyslog_default'
      }
      elsif $::operatingsystemmajrelease == 5 {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default'
      }
      elsif $::operatingsystemmajrelease == 6 {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default'
        $default_inputs         = undef
      }
      elsif $::operatingsystemmajrelease >= 7 {
        $rsyslog_package_name   = 'rsyslog'
        $mysql_package_name     = 'rsyslog-mysql'
        $pgsql_package_name     = 'rsyslog-pgsql'
        $gnutls_package_name    = 'rsyslog-gnutls'
        $relp_package_name      = 'rsyslog-relp'
        $default_config_file    = 'rsyslog_default_rhel7'
        $default_inputs = {
          'input1' => {
            'input_type' => 'imuxsock',
            'input_options' => {
              'Socket' => '/run/systemd/journal/syslog'
            }
          }
        }
      } else {
        $rsyslog_package_name   = 'rsyslog5'
        $mysql_package_name     = 'rsyslog5-mysql'
        $pgsql_package_name     = 'rsyslog5-pgsql'
        $gnutls_package_name    = 'rsyslog5-gnutls'
        $relp_package_name      = 'librelp'
        $default_config_file    = 'rsyslog_default'
      }
      $package_status         = 'latest'
      $rsyslog_d              = '/etc/rsyslog.d/'
      $rsyslog_conf           = '/etc/rsyslog.conf'
      $rsyslog_default        = '/etc/sysconfig/rsyslog'
      $run_group              = 'root'
      $log_group              = 'root'
      $log_style              = 'redhat'
      $umask                  = '0000'
      $perm_file              = '0600'
      $perm_dir               = '0750'
      $spool_dir              = '/var/lib/rsyslog'
      $service_name           = 'rsyslog'
      $ssl                    = false
      $service_hasrestart     = true
      $service_hasstatus      = true
      $main_queue = {
        'queue.filename' => 'main',
        'queue.spoolDirectory' => $spool_dir,
        'queue.maxdiskspace' => '1g',
        'queue.timeoutenqueue' => '0',
        'queue.type' => 'LinkedList',
        'queue.saveonshutdown' => 'on'
      }
      $default_ruleset_actions = {
          'action1' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/messages', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("*.info;mail.none;authpriv.none;cron.none")',
            'order' => '010'
          },
          'action2' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/secure', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("authpriv.*")',
            'order' => '011'
          },
          'action3' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/maillog', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("mail.*")',
            'order' => '012'
          },
          'action4' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/cron', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("cron.*")',
            'order' => '013'
          },
          'action5' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/spooler', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("uucp,news.crit")',
            'order' => '014'
          },
          'action6' => {
            'action_type' => 'omfile',
            'action_options' => { 'file' => '/var/log/boot.log', 'template' => 'RSYSLOG_FileFormat' },
            'action_if' => 'prifilt("local7.*")',
            'order' => '015'
          }
        
      }
    }
    suse: {
      $rsyslog_package_name   = 'rsyslog'
      $relp_package_name      = false
      $mysql_package_name     = false
      $pgsql_package_name     = false
      $gnutls_package_name    = false
      $package_status         = 'latest'
      $rsyslog_d              = '/etc/rsyslog.d/'
      $rsyslog_conf           = '/etc/rsyslog.conf'
      $rsyslog_default        = '/etc/sysconfig/syslog'
      $run_group              = 'root'
      $log_group              = 'root'
      $log_style              = 'debian'
      $umask                  = false
      $perm_file              = '0600'
      $perm_dir               = '0750'
      $spool_dir              = '/var/spool/rsyslog/'
      $service_name           = 'syslog'
      $client_conf            = 'client'
      $server_conf            = 'server'
  }
    freebsd: {
      $rsyslog_package_name   = 'sysutils/rsyslog5'
      $relp_package_name      = 'sysutils/rsyslog5-relp'
      $mysql_package_name     = 'sysutils/rsyslog5-mysql'
      $pgsql_package_name     = 'sysutils/rsyslog5-pgsql'
      $gnutls_package_name    = 'sysutils/rsyslog5-gnutls'
      $package_status         = 'present'
      $rsyslog_d              = '/etc/syslog.d/'
      $rsyslog_conf           = '/etc/syslog.conf'
      $rsyslog_default        = '/etc/defaults/syslogd'
      $default_config_file    = 'rsyslog_default'
      $run_group              = 'wheel'
      $log_group              = 'wheel'
      $log_style              = 'debian'
      $umask                  = false
      $perm_file              = '0640'
      $perm_dir               = '0755'
      $spool_dir              = '/var/spool/syslog'
      $service_name           = 'syslogd'
      $client_conf            = 'client'
      $server_conf            = 'server'
      $ssl                    = false
      $service_hasrestart     = true
      $service_hasstatus      = true
    }

    default: {
      case $::operatingsystem {
        gentoo: {
          $rsyslog_package_name   = 'app-admin/rsyslog'
          $relp_package_name      = false
          $mysql_package_name     = 'rsyslog-mysql'
          $pgsql_package_name     = 'rsyslog-pgsql'
          $gnutls_package_name    = false
          $package_status         = 'latest'
          $rsyslog_d              = '/etc/rsyslog.d/'
          $rsyslog_conf           = '/etc/rsyslog.conf'
          $rsyslog_default        = '/etc/conf.d/rsyslog'
          $default_config_file    = 'rsyslog_default_gentoo'
          $run_group              = 'root'
          $log_group              = 'adm'
          $log_style              = 'debian'
          $umask                  = false
          $perm_file              = '0640'
          $perm_dir               = '0755'
          $spool_dir              = '/var/spool/rsyslog'
          $service_name           = 'rsyslog'
          $client_conf            = 'client'
          $server_conf            = 'server'
          $ssl                    = false
          $service_hasrestart     = true
          $service_hasstatus      = true

        }
        default: {
          fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
        }
      }
    }
  }
}
