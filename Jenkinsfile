pipeline {
    agent any
    environment {
        registry = "324022521133.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/krushnaprakash/swarna_adarsh_web.git'
            }
        }
        stage('Building image') {
            steps {
                script {
                    sh 'docker build -t jenkins-ecr .'
                }
            }
        }
        stage('Pushing to ECR') {
            steps {  
                sh '''
                    aws ecr get-login-password --region ap-south-1 |
                    docker login --username AWS --password-stdin 324022521133.dkr.ecr.ap-south-1.amazonaws.com
                '''
                sh 'docker tag jenkins-ecr:latest 324022521133.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
                sh 'docker push 324022521133.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
            }
        }
        stage('Stop previous containers') {
            steps {
                sh 'docker ps -f name=mypythonContainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -f name=mypythonContainer -q | xargs -r docker container rm'
            }
        }
        stage('Docker Run') {
            steps {
                script {
                    sh 'docker run -d -p 3000:3000 --rm --name mypythonContainer 324022521133.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
                }
            }
        }
    }
}
