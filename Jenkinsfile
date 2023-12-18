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
		stage('Deploy to Tomcat') {
     steps { 
	     bat "copy /target/onlinebookstore.war /opt/tomcat/webapps
		}
               }
            }
