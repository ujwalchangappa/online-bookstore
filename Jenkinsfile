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
	     sh "cp /var/lib/jenkins/workspace/Online-Bookstore/target/onlinebookstore.war /opt/tomcat/webapps"
		}
               }
            }
}
