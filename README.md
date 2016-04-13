This module attempts to manage rsyslog client and server via Puppet using the Rainer Script syntax.  There's no concept of client/server instead you define inputs/rulesets/actions on where logs go.

## REQUIREMENTS

* Puppet >= 3 
* Rsyslog >= 7

## USAGE

### Using default values
```
---
classes:
  - rsyslog
```

### Forwarding Logs to remote server
```
---
classes:
  - rsyslog
rsyslog::ruleset_merge_actions:
  action0:
    action_type: 'omfwd'
    action_options:
      target: 'logrelay.myhost.com'
      port: '10514'
      protocol: 'tcp'
      template: 'RSYSLOG_ForwardFormat'
    order: '005'
```

### Recieving relayed logs

```puppet
---
classes:
  - rsyslog
rsyslog::inputs:
  imrelp_10514:
    input_type: 'imtcp'
    input_options:
      port: '10514'
      ruleset: 'RemoteLogs'
rsyslog::modules:
  imtcp:
    module_name: 'imtcp'
rsyslog::rulesets:
  '10_remote_tcp':
    ruleset_name: 'RemoteLogs'
    ruleset_options:
      relp_action1:
        action_type: 'omfile'
        action_options:
          file: '/var/log/remote'
          template: 'RSYSLOG_FileFormat'
```

### Combined recieving logs and relying them to more than 1 remote

```puppet
---
classes:
  - rsyslog
rsyslog::modules:
  imptcp:
    module_name: 'imptcp'
rsyslog::inputs:
  input_imptcp_10514:
    input_type: 'imptcp'
    input_options:
      port: '10514'
      ruleset: 'RelayLogs_10514'
rsyslog::rulesets:
  '10_RelayLogs_10514':
    ruleset_name: 'RelayLogs_10514'
    ruleset_options:
      relay_action1:
        action_type: 'omfwd'
        action_options:
          target: 'logtarget1.com'
          port: '10514'
          protocol: 'tcp'
          template: 'RSYSLOG_ForwardFormat'
      relay_action2:
        action_type: 'omfwd'
        action_options:
          target: 'logtarget2.com'
          port: '5000'
          protocol: 'tcp'
          template: 'RSYSLOG_ForwardFormat'

```

