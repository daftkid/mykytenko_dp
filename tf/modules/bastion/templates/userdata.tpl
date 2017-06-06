#cloud-config
write_files:
  - path: /root/awslogs.conf
    permissions: '0644'
    owner: root:root
    content: |
      [general]
      state_file = /var/awslogs/state/agent-state
      [${authlog_path}]
      datetime_format = %b %d %H:%M:%S
      file = ${authlog_path}
      buffer_duration = 5000
      log_stream_name = {instance_id}-auth
      initial_position = start_of_file
      log_group_name = /bastion-${bastion_environment}/instance-logs
      [${syslog_path}]
      datetime_format = %b %d %H:%M:%S
      file = ${syslog_path}
      buffer_duration = 5000
      log_stream_name = {instance_id}-syslog
      initial_position = start_of_file
      log_group_name = /bastion-${bastion_environment}/instance-logs
  - path: /etc/facter/facts.d/instance_classification.yaml
    permissions: '0444'
    owner: root:root
    content: |
      ---
      instance_role: ${instance_role}
      instance_tier: ${instance_tier}
      instance_application: none

runcmd:
  - wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb -O /tmp/puppetlabs-release-pc1-jessie.deb
  - dpkg -i /tmp/puppetlabs-release-pc1-jessie.deb
  - apt-get update
  - apt-get install -y puppet-agent
  - /opt/puppetlabs/bin/puppet config set environment ${puppet_environment}
  - /opt/puppetlabs/bin/puppet agent -t --waitforcert=60
  - /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true