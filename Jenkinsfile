pipeline {
    agent any
    stages {
        stage('Repo Cloning') {
            steps {
               git branch: 'master', url: 'https://github.com/deva0209/star-agile-health-care.git'
            }
        }
        stage('Packaging repo') {
            steps {
               sh 'mvn clean package'
            }
        }
        stage('Publish HTML reports') {
	     steps {
		    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
	stage('Build Docker Image') {
		steps {
			sh 'docker build -t deva0209/medicure:latest .'	
		}
	}
	stage('Push image to Docker Hub') {
	     steps {
		withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USER')]) {
			sh "docker login -u ${env.DOCKERHUB_USER} -p ${env.DOCKERHUB_PASSWORD}"
			sh 'docker push deva0209/medicure:latest'
		}
	     }
	}
	stage('Execute the Terraform File') {
		steps {
			sh 'echo "123456" | sudo -S chmod 600 gnan.pem'
			sh 'terraform init'
			sh 'terraform validate'
			sh 'terraform plan'
			sh 'terraform apply --auto-approve'
			
		}
	}
  }
}
