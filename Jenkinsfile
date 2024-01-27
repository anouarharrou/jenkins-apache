pipeline {
    agent any

    stages {
        stage('CHECKOUT_SCM') {
            steps {
                checkout scm
            }
        }

        stage('DEPLOY') {
            withCredentials([ 
            file(credentialsId: 'PAT', variable: 'SSHKEY'),
            file(credentialsId: 'kube-config', variable: 'KUBECONFIG')
            ]) 
            steps {
                    sh """
                    cd ansible
                    echo " This will deploy the service: ${SERVICE} with version: ${VERSION}"
                    echo " This's the Personal Access Token for Github: ${PAT}"
                    echo " This's the Kubeconfig file: ${KUBECONFIG}"
                    """
                }
            }
        }
    }
}

