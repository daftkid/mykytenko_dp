#cloud-config
write_files:
  - path: /root/.pgpass
    permissions: '0600'
    owner: root:root
    content: |
      ${rds_host}:${rds_port}:*:${rds_username}:${rds_password}

ssh_keys:
  dsa_private: |
    -----BEGIN DSA PRIVATE KEY-----
    MIIBuwIBAAKBgQDbpu/lFepmfSzkz9w5pNTk4ePiyDvC5K5WzfDPDq6RHz1OwFAg
    nMr8Aj8lNNfUUGpoBGJtrhSUpJlQqb6ffc/v6gJ3iFSnG898cWs9p3ZZj3O8POql
    8o2NRnLKcvQrvUAl6pRCkDToVoNla+bfpN/PpEk7FoZZwpqp+R9pSoL5dwIVAM9+
    18CeRj6G/Wd3tCYbDw8AZq85AoGAZfGlpfdZBXU1szJ/CPN+ndbaMPnlE3fy+Wob
    vYciCZvSO2F6Vw/dXtCTAsSTTRXgH7DeyTyQoodLwF2bvriJqJiNugh//I+J5odf
    QCbYiTcSr6Ru8cTKW4prDeEjjK1+CHaukl5mcLaEcraLroQws6s9ddedMApU9CG8
    br5QwucCgYEAkwidxvRd7hT1E6Ap/tHvr8qhtN3EQKEXd6twXKAZ2ohdfB6XcNhG
    wi9sl72KmWJYlHUAUmvMO0MK9PMdE8ShYFvk5toOtkgVaDBPV49ScXX1Naytel6v
    8VAlXdWw1fLaZFoInjkuDpBjjr9cqBgnyg7A9ek/pQpWZ8eV/tovC4gCFGSWHsE2
    iIyEgznOulJTgQizo5Ny
    -----END DSA PRIVATE KEY-----
  dsa_public: ssh-dss AAAAB3NzaC1kc3MAAACBANum7+UV6mZ9LOTP3Dmk1OTh4+LIO8LkrlbN8M8OrpEfPU7AUCCcyvwCPyU019RQamgEYm2uFJSkmVCpvp99z+/qAneIVKcbz3xxaz2ndlmPc7w86qXyjY1Gcspy9Cu9QCXqlEKQNOhWg2Vr5t+k38+kSTsWhlnCmqn5H2lKgvl3AAAAFQDPftfAnkY+hv1nd7QmGw8PAGavOQAAAIBl8aWl91kFdTWzMn8I836d1tow+eUTd/L5ahu9hyIJm9I7YXpXD91e0JMCxJNNFeAfsN7JPJCih0vAXZu+uImomI26CH/8j4nmh19AJtiJNxKvpG7xxMpbimsN4SOMrX4Idq6SXmZwtoRytouuhDCzqz11150wClT0IbxuvlDC5wAAAIEAkwidxvRd7hT1E6Ap/tHvr8qhtN3EQKEXd6twXKAZ2ohdfB6XcNhGwi9sl72KmWJYlHUAUmvMO0MK9PMdE8ShYFvk5toOtkgVaDBPV49ScXX1Naytel6v8VAlXdWw1fLaZFoInjkuDpBjjr9cqBgnyg7A9ek/pQpWZ8eV/tovC4g= Gerrit_server

  ecdsa_private: |
    -----BEGIN EC PRIVATE KEY-----
    MHcCAQEEICHVwXdef9uucO9MQ0hIKvIXAE7vsBl9joX6qVIurfl+oAoGCCqGSM49
    AwEHoUQDQgAETROCkRKQNrOk8FiZpz6VFKkL4DgxceCpoIAXFR7v9HI+DD7RyDzk
    +rDCNobQ8U25DGMeZ2bdp9P6GhveSFDsKg==
    -----END EC PRIVATE KEY-----
  ecdsa_public: ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBE0TgpESkDazpPBYmac+lRSpC+A4MXHgqaCAFxUe7/RyPgw+0cg85PqwwjaG0PFNuQxjHmdm3afT+hob3khQ7Co= Gerrit_server

  ed25519_private: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
    QyNTUxOQAAACBTaSylzgcxr0uNRh8nyMxyEyTuf8tT7i5wQsRS4LgGfQAAAIh70D7qe9A+
    6gAAAAtzc2gtZWQyNTUxOQAAACBTaSylzgcxr0uNRh8nyMxyEyTuf8tT7i5wQsRS4LgGfQ
    AAAEB+rhlvCwwvFoXuCMCovqtugn8++VKrGgZmiq98CcXx4FNpLKXOBzGvS41GHyfIzHIT
    JO5/y1PuLnBCxFLguAZ9AAAAAAECAwQF
    -----END OPENSSH PRIVATE KEY-----
  ed25519_public: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNpLKXOBzGvS41GHyfIzHITJO5/y1PuLnBCxFLguAZ9

  rsa_private: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpQIBAAKCAQEAzniHrRY392GF8+ggzz2tkISw3gdlp5s36jEhE8xxjF25s2JO
    ZoSWZCqRIYRDk4BPeb+iulEg3kkEXuAGZJ7zoyWrKxoqtzrZNPgJzmTBZoFtsvbp
    Cr0CLYKaX8cARABdqQDDsanKNL8beRgViFzkd9KsRpgauiE6RNjc67UHwEhw0zLx
    aw7YxJAPkbEf389xtsUAPMDMD+wVAbRxW8peMGR1hmY8Uuu5jOF9PH6R/nsqmudV
    3pMD6G4jq2I53fiS+zUzdiimc0yo45HdeuHeXUmDXO+cdpmq5+qKliVFXYu5aqaG
    sl52SN+oyrBjyZSWknk0AbcjMB5vfC4es7bAdQIDAQABAoIBAQDGPE0v71Q+zUC6
    ZNYThEl/pxbVpk6AtPPjg9YZV0JyHY7tX2ac4ZIvi/saLg5fsWMdJtSLhNdE9OAg
    Y4Ff3IlZzBHi6VW35OWlCL0JkA1saLo1iQFJER3lKi8j5EIqCBvk5tn9W2LMb+xl
    wKzz5xRowzoq8WE/8iUq8vhxyrctceQVRYhcAJPxgnWLL1zbpz1bMBfiV+mnIc/6
    /HFvLIVWvS2On47S2tsevelLeItzyWsdiUHpt5E5aWw9KaetB+dFhIhqLVLWGlaJ
    4Zcs4Qo99E9I3EscMkbj6A0rWbVq5T6QMczP913i53S9tPl3nNyNEmNSuUaJkrjX
    W/ZOGU5hAoGBAP89sEhvwsKbBKuOMpRdVUH+oQpb4cQdlrfm6dma2f8U4VAf8E4q
    cNtvj98BjO9qkidSGGqc9xv0bEmzV3p8IS0TUzBz7CQfstPvu73QwmxdJLP8u2dG
    OgGx6hTawu2AGBH/emOdxmAOeD0rr/FP8C0dTsC8BTt+UTeSKA8BU0LdAoGBAM8V
    tp2qQO9kvjrg/GkvGQgLxBQjSzYm6IgkRfN0UEy8v1y7byRs+llYjCJ5YRMfUya9
    w05FRtz5/UN9hDuLfOfyz8G/Z55VBznnBCNGgnmujXQ90rP8F6L4G8VsZTmB/XBV
    e2DkwaBfK1fDI5X2RSoZiT5wT0a58hXMvFBJm155AoGAF5D3jMic3+D2PmzDqMUx
    UQWUkuNG5hehSduNLeVJSW8BGqfIRT9P6kLTstBu1dAuLGk9DeLuQeuAcBGZ+xoo
    6gOFw8yAOhmfJkhVOkJjISQ8dk3Yc8GdK3jk1wYXx1vzXP4Mq9PudAICAgvdk9dA
    orm5AryZcxPHpezdu/zwVhUCgYEAvpcwXImee/XPcucwyCn1sscJbrNQ/ITwzKP9
    0WRCp22r/c/wKak2/FYXm371DiFtaSGLiBUQdD6MjroNorPtgJikB6B+4GVHYk4x
    K7owSYeSXuKrcsVYh8Ar5xatTzFJLUMva2z+m/gbLwnFTba7z1RzUQkSnXhzywaE
    ZqxoF5kCgYEAkebJ/JQtKO3q103raOZFJGENO9Ms7+FEKnNdUK3rUwWNIE5kDgpu
    gMNB5/gtliwELMOv7e/odO8l53Ea/TA89c5LI+Y+ov9oqNvf+sTmP6hMP2pl9pzB
    6HteEoM9YBbXBj03JIiFMGC3RNdMcx+p2Sy1eX1tZWqMZZbHMASpmqA=
    -----END RSA PRIVATE KEY-----
  rsa_public: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOeIetFjf3YYXz6CDPPa2QhLDeB2WnmzfqMSETzHGMXbmzYk5mhJZkKpEhhEOTgE95v6K6USDeSQRe4AZknvOjJasrGiq3Otk0+AnOZMFmgW2y9ukKvQItgppfxwBEAF2pAMOxqco0vxt5GBWIXOR30qxGmBq6ITpE2NzrtQfASHDTMvFrDtjEkA+RsR/fz3G2xQA8wMwP7BUBtHFbyl4wZHWGZjxS67mM4X08fpH+eyqa51XekwPobiOrYjnd+JL7NTN2KKZzTKjjkd164d5dSYNc75x2marn6oqWJUVdi7lqpoayXnZI36jKsGPJlJaSeTQBtyMwHm98Lh6ztsB1 Gerrit_server

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
