pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
    }
    stages {
        stage('Build') {
            steps{
                 bat "robot --version"
            }
        }
        stage('Execute') {
            steps{

                 bat """${NEWMAN_PATH_VAR}newman run https://api.getpostman.com/collections\\1975691-3e97bc95-2f11-4273-92dd-a675db37eef1?apikey=%POSTMAN_API_KEY% --environment https://api.getpostman.com/environments\\1975691-780421db-70ce-49de-9345-9d717c47aa4c?apikey=%POSTMAN_API_KEY% --reporters cli,html --disable-unicode"""
            }
        }
    }
}