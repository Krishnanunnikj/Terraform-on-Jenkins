pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                input message: 'Do you want to apply this plan?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                bat 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
