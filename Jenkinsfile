pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        // ansiColor('xterm')
    }
    parameters {
         choice(name: 'action', choices: ['Apply', 'Destroy'], description: 'Pick something')
    }
    stages {
        stage('init') {
            steps {
                sh """
                 cd 01-vpc
                 terraform init -reconfigure
                """
                }
            }
        stage('plan') {
            when {
                expression{
                    params.action == 'Apply'
                }
            }
            steps {
                sh """
                 cd 01-vpc
                 terraform plan
                """
            }
        }
        stage('Deploy') {
             when {
                expression{
                    parms.action == 'Apply'
                }
            }
            input {
                message "should we continue?"
                ok "yes, we should!"
            }
            
            steps {
                sh """
                 cd 01-vpc
                 terraform apply -auto-approve
                """
            }
        }
    
    stage('Destroy') {
             when {
                expression{
                    parms.action == 'Destroy'
                }
            }
            steps {
                sh """
                 cd 01-vpc
                 terraform destroy -auto-approve
                """
                }
            }
        }
    
        post { 
            always { 
                echo 'I will always say Hello again!'
                deleteDir()
            }
            success { 
                echo 'I will run when pipeline is successful!'
            }
            failure { 
                echo 'I will run when pipeline is failed!'
            }
        }
    }
    
