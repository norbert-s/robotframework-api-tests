pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
        PYTHON_PATH = "${PYTHON_PATH}"
        PYTHON_SITE_PACKAGES = "${PYTHON_SITE_PACKAGES}"
    }
    stages {
        stage('Build') {
            steps{
                 bat """C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\python --version"""

            }
        }
        stage('Execute issuetracker tests') {
            steps{
                bat """${PYTHON_PATH} -m robot.run --pythonpath ${PYTHON_SITE_PACKAGES} -d robot/results_issuetracker -i issuetracker -i delete_last_entry robot/testfiles/issuetracker.robot"""
                }
        }
        stage('Execute mock tests tests') {
            steps{
                bat """${PYTHON_PATH} -m robot.run --pythonpath ${PYTHON_SITE_PACKAGES} -d robot/results_mocking -v api_key_postman:%POSTMAN_API_KEY% robot/testfiles/postman_mock_server_tests.robot"""
                }
        }
    }
}