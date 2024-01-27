def call(Map config) {

  // Component config
  def message = config["message"]

  if (!steps.isEmpty()) currentBuild.displayName += " [${ steps.join(', ') }]"
  currentBuild.description = "${BUILD_USER} ($BUILD_USER_ID)"
  currentBuild.description += " started this job (${BUILD_URL})"
podTemplate(
  containers: [
    containerTemplate(name: 'ansible', image: 'ansible:latest', alwaysPullImage: false, ttyEnabled: true, command: 'cat')
  ]
){
  node(POD_LABEL) {
    stage('CHECKOU_SCM') {
      checkout scm
    }
    stage("DEPLOY"){
      container('ansible') {
        withCredentials([ 
            file(credentialsId: 'ssh-key', variable: 'SSHKEY'),
        ]) 
              sh """
              cd ansible
              echo "${message}"
              """
      }
    }
    }
  }
}

// ansible-playbook service.yml -i hosts.ini --private-key $SSHKEY -u cloud-user -v --extra-vars "service=${SERVICE} version=${VERSION}"