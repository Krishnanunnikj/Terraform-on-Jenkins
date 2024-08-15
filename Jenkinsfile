pipeline {
    agent any

    environment {
        TERRAFORM_HOME = 'C:\\terraform' // Update this path to where Terraform is installed
        PATH = "${env.TERRAFORM_HOME};${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Terraform') {
            steps {
                script {
                    try {
                        bat 'terraform version'
                    } catch (Exception e) {
                        error "Terraform is not installed or not in PATH. Please ensure Terraform is installed and the path is correct in the Jenkinsfile. Error: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    try {
                        bat 'terraform init'
                    } catch (Exception e) {
                        error "Terraform init failed: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    try {
                        bat 'terraform plan -out=tfplan'
                    } catch (Exception e) {
                        error "Terraform plan failed: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
            steps {
                script {
                    def plan = readFile 'tfplan'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    try {
                        bat 'terraform apply -auto-approve tfplan'
                    } catch (Exception e) {
                        error "Terraform apply failed: ${e.getMessage()}"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Terraform execution succeeded!'
        }
        failure {
            echo 'Terraform execution failed!'
        }
    }
}
