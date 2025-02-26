pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'version', defaultValue: '', description: 'version of artifact')
        string(name: 'environment', defaultValue: 'dev', description: 'Which environment?')
        booleanParam(name: 'Destroy', defaultValue: 'false', description: 'destroy all')
    }
    // build
    stages {
        stage('print the version') {
            steps {
                sh """
                    echo "version: ${params.version}"
                    echo "environment: ${params.environment}"
                """
            }
        }
        stage('init') {
            steps {
                sh """
                    cd terraform
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure 
                """
            }
        }
        stage('plan') {
            steps {
                sh """
                    cd terraform
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" 
                """
            }
        }
         stage('apply') {
            steps {
                sh """
                    cd terraform
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
        stage('destroy') {
            when{
                expression{
                    params.Destroy
                }
            }
            steps {
                sh """
                    cd terraform
                    terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
    }

    // post build
    post { 
        always { 
            echo 'pipeline fails r success i will execute'
            deleteDir()
        }
        failure { 
            echo 'pipeline failed'
        }
        success{
            echo 'pipeline success'
        }
    }
}