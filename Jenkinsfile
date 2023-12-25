pipeline {  
    agent any  
        stages {  
       	    stage("git_checkout") {  
           	    steps {  
              	    echo "cloning repository" 
              	    echo "repo cloned successfully"  
              	    }  
         	    }
		    stage("Build") {
		    steps {
		    sh "mvn clean package"
		    }
		       }
		stage("Sonarqube Analysis "){
               steps {
        withSonarQubeEnv(installationName: 'SonarQube') { 
       sh "mvn clean verify sonar:sonar -Dsonar.login=squ_41d992f7cfadf0df0e4cc8a37f80a3d4eb9641dc"
        }
      }
    }
		stage("Quality Gate"){
            steps {
                 script {
                     waitForQualityGate abortPipeline: false, credentialsId: 'SonarQube-Token' 
                 }
             } 
         }
	
		stage('Deploy to Tomcat') {
     steps { 
	     sh "cp /var/lib/jenkins/workspace/Online-Bookstore/target/onlinebookstore.war /opt/tomcat/webapps"
		}
		  }
		stage('Build and Push Docker Image') {
      environment {
        DOCKER_IMAGE = "ujwal30/bookstore:${BUILD_NUMBER}"
        REGISTRY_CREDENTIALS = credentials('docker-cred')
      }
      steps {
        script {
            sh 'cd /var/lib/jenkins/workspace/Online-Bookstore/ && docker build -t ${DOCKER_IMAGE} .'
            def dockerImage = docker.image("${DOCKER_IMAGE}")
            docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                dockerImage.push()
            }
        }
      }
    }
            }
}
