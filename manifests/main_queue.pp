class rsyslog::main_queue (
  $checkpointinterval = undef,
  $dequeuebatchsize = undef,
  $dequeueslowdown = undef,
  $discardmark = undef,
  $discardseverity = undef,
  $filename = 'main',
  $highwatermark = undef,
  $immediateshutdown = undef,
  $lowwatermark = undef,
  $maxdisksize = undef,
  $timeoutactioncompletion = undef,
  $timeoutenqueue = undef,
  $timeoutshutdown = undef,
  $workertimeoutthreadshutdown = undef,
  $queuetype = 'LinkedList',
  $saveonshutdown = undef,
  $workerthreads = undef,
  $workerthreadminumummessages = undef
) {

  concat::fragment {
    "default_mail_queue_config":
      target => $rsyslog::rsyslog_conf,
      order  => '110',
      content => template('rsyslog/rsyslog.conf/main_queue.erb');
  }

}
