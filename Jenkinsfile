pipeline {  
    agent any  
	environment { 
   NAME = "onlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   IMAGE_REPO="bookstore"
   IMAGE_URL='hub.docker.com'
   }   
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
 //		stage("Sonarqube Analysis"){
   //            steps {
     //   withSonarQubeEnv(installationName: 'SonarQube') { 
     //  sh "mvn clean verify sonar:sonar -Dsonar.login=sonarqube"
	//	sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
       // }
     // }
   // }
	 //stage("Quality gate") {
	//	steps {
        // script {
          //  def scannerHome = tool 'SonarQube';
           // withSonarQubeEnv("SonarQube") {
            //  sh "${scannerHome}/bin/sonar-scanner"
          //  }
       // }
    //  }
	// }
	//	stage('Deploy to Tomcat') {
    // steps { 
	//     sh "cp /var/lib/jenkins/workspace/Online-Bookstore/target/onlinebookstore.war /opt/tomcat/webapps"
	//	}
	//	  }
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
      } }
			 stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                withAWS(credentials: 'aws', region: 'us-east-1') {
                  script {
                    sh ('aws eks update-kubeconfig --name poc-cluster --region us-east-1')
                    sh "echo ${IMAGE_URL}/${IMAGE_REPO}/${NAME}:${VERSION}"
                    //sh 'envsubst < k8s-specifications/|kubectl apply -f -'
                    
                    sh "kubectl apply -f k8s/"
                     sh 'kubectl set image deployments/onlinebookstore onlinebookstore-container=${IMAGE_REPO}/${NAME}:${VERSION}'
                   
                   
                }
                }
        }
    }  
    
            }
}
