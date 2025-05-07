pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    stages {
        stage('init') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')])
                {
                sh """
                 cd 01-vpc
                 terraform init -reconfigure
                """
                }
            }
        }
        // stage('plan') {
        //     steps {
        //         sh 'echo this is a plan step'
        //         sh 'sleep 10'
        //     }
        // }
        // stage('Deploy') {
        //     steps {
        //         sh 'echo this is a deploy step'
        //     }
        // }
    }
        post { 
            always { 
                echo 'I will always say Hello again!'
            }
            success { 
                echo 'I will run when pipeline is successful!'
            }
            failure { 
                echo 'I will run when pipeline is failed!'
            }
        }
    }
