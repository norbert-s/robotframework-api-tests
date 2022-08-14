pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
        //ROBOT_PATH = ${ROBOT_PATH}
    }
    stages {
        stage('Build') {
            steps{
                 bat "python --version"
            }
        }
       
    }
}