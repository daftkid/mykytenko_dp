#cloud-config
write_files:
  - path: /root/.pgpass
    permissions: '0600'
    owner: root:root
    content: |
      ${rds_host}:${rds_port}:*:${rds_username}:${rds_password}

package_upgrade: true

packages:
  - httpd
  - postgresql
  - python
  - vim
  - java
  - nfs-utils
  - git
  - tmux

runcmd:
  - service httpd start
  - chkconfig httpd on
  - mkdir -p /efs
  - mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone).${efs_fs_id}.efs.us-east-1.amazonaws.com:/ /efs
