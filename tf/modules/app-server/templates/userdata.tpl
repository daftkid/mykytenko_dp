#cloud-config
package_upgrade: true

yum_repos:
    # The name of the repository
    jenkins-repo:
        # Any repository configuration options
        # See: man yum.conf
        #
        # This one is required!
        baseurl: http://pkg.jenkins.io/redhat
        enabled: true
        gpgcheck: true
        gpgkey: https://jenkins-ci.org/redhat/jenkins-ci.org.key
        name: Jenkins

packages:
  - wget
  - java
  - git
  - vim
  - jenkins

runcmd:
  - sed -i 's/JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"/JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Dmail.smtp.starttls.enable=true"/' /etc/sysconfig/jenkins
  - systemctl enable jenkins
  - systemctl start jenkins
