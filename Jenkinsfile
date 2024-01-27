pipeline {
    agent any

    stages {
        stage('CHECKOUT_SCM') {
            steps {
                checkout scm
            }
        }

        stage('DEPLOY') {
            steps {
                echo "Hello!"
                echo "This script will deploy: ${SERVICE} with version ${VERSION}"
            }
        }
    }
}

