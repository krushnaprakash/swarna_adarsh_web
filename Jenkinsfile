pipeline {
    agent any
     environment {
        registry = "150899561976.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr>"
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
    stages {
          stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/krushnaprakash/swarna_adarsh_web.git'
            }
        }
           stage('Building image') {
             steps{
                  script {
                   sh 'docker build -t jenkins-ecr .'

                   }
      }
           }
    
            stage('Pushing to ECR') {
             steps{  
                  script {
               withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws_cred', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 150899561976.dkr.ecr.ap-south-1.amazonaws.com'
     sh 'docker push 150899561976.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
}

}
                  }
            }
             stage('stop previous containers') {
               steps {
            sh 'docker ps -f name=mypythonContainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=mypythonContainer -q | xargs -r docker container rm'
         }
       }
            stage('Docker Run') {
              steps{
                   script {
                sh 'docker run -d -p 3000:3000 --rm --name mypythonContainer 150899561976.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'     
      }
    }
        }
    }
  }