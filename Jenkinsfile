pipeline {  
    agent any  
	environment { 
   NAME = "onlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   IMAGE_REPO="ujwal30"
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
		 stage('Build result') {
     steps {
            echo "Running ${VERSION} on ${env.JENKINS_URL}"
            //git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Hemantakumarpati/OnlineBookStore.git'
            //echo "for brnach ${env.BRANCH_NAME}"
            sh "docker build -t ${NAME} ."
            sh "docker tag ${NAME}:latest ${IMAGE_REPO}/${NAME}:${VERSION}"
        }
    } 
		stage('Push result image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker push ${IMAGE_REPO}/${NAME}:${VERSION}"
           
        }
      }
    }
    
			 stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                withAWS(credentials: 'aws', region: 'us-east-1') {
                  script {
                    sh ('aws eks update-kubeconfig --name poc-cluster --region us-east-1')
                    sh "echo ${IMAGE_URL}/${IMAGE_REPO}/${NAME}:${VERSION}"
                    //sh 'envsubst < k8s-specifications/|kubectl apply -f -'
                    
                    sh "kubectl apply -f K8s/"
                     sh 'kubectl set image deployments/onlinebookstore onlinebookstore-container=${IMAGE_REPO}/${NAME}:${VERSION}'
                   
                   
                }
                }
        }
    }  
    
            }
}
