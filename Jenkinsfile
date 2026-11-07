pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building Python Calculator'
                sh 'python3 -m py_compile calculator.py'
            }
        }

        stage('Test') {
            steps {
                echo 'Running Unit Tests'
                sh 'python3 -m pytest -v'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging Calculator'
                sh 'zip -r calculator-package.zip calculator.py test_calculator.py'
                archiveArtifacts artifacts: 'calculator-package.zip',
                                 fingerprint: true
            }
        }

                stage('Docker Image') {
            steps {
                echo 'Building Docker image'
                sh 'docker build -t usn-calculator:${BUILD_NUMBER} .'
                sh 'docker tag usn-calculator:${BUILD_NUMBER} usn-calculator:latest'
            }
        }

        stage('Deploy to Staging') {
            steps {
                input message: 'Approve deployment to staging?',
                      ok: 'Approve'
                echo 'Application deployed to staging successfully!'
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline completed successfully!'
        }
        failure {
            echo 'CI/CD Pipeline failed!'
        }
    }
}
