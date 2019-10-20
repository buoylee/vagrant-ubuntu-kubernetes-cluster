pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                println "Triggered by git github webhook"
                println "Build" 
            }
        }
        stage('Test') { 
            steps {
                println "Test" 
            }
        }
        stage('Deploy') { 
            steps {
                println "Deploy" 
            }
        }
    }
}
