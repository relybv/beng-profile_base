node {
   wrap([$class: 'AnsiColorBuildWrapper']) {
      properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '3')), pipelineTriggers([pollSCM('H/15 * * * *')])])
      stage('Checkout') { // for display purposes
         // Clean workspace before checkout
         step ([$class: 'WsCleanup'])
         // Get some code from a GitHub repository
         git 'https://github.com/relybv/beng-profile_base.git'
      }
      stage('Dependencies') {
         sh 'cd $WORKSPACE'
         sh '/usr/bin/bundle install --path vendor/bundle'
         sh '/opt/puppetlabs/puppet/bin/rake spec_prep'
      }
      stage('Syntax') {
         sh '/usr/bin/bundle exec rake syntax'
      }
      stage('Lint') {
         sh '/usr/bin/bundle exec rake lint'
      }
      stage('Spec') {
         catchError {
            sh '/opt/puppetlabs/puppet/bin/rake spec_clean'
            sh '/usr/bin/bundle exec rake spec'
         }
      }
      stage('Documentation') {
         sh '/opt/puppetlabs/bin/puppet resource package yard provider=puppet_gem'
         sh '/opt/puppetlabs/bin/puppet module install puppetlabs-strings'
         sh '/opt/puppetlabs/puppet/bin/puppet strings'
         publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: false, reportDir: 'doc', reportFiles: 'index.html', reportName: 'HTML Report'])
      }
      stage('Acceptance CentOS') {
         withEnv(['OS_AUTH_URL=https://access.openstack.rely.nl:5000/v2.0', 'OS_TENANT_ID=10593dbf4f8d4296a25cf942f0567050', 'OS_TENANT_NAME=lab', 'OS_PROJECT_NAME=lab', 'OS_REGION_NAME=RegionOne']) {
            withCredentials([usernamePassword(credentialsId: 'OS_CERT', passwordVariable: 'OS_PASSWORD', usernameVariable: 'OS_USERNAME')]) {
               catchError {
                 sh 'BEAKER_set="openstack-centos-7-x64" /usr/bin/bundle exec rake beaker_fixtures'
               }
            }
         }
      }
   }
}