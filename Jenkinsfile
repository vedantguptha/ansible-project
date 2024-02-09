pipeline {
    agent any
    tools {
        maven "maven"
    }

    stages {
        stage('Pull Code Form SCM') {
            steps {
                git 'https://github.com/vedantguptha/ansible-project.git'
  
            }
        }
        stage('Clean') {
            steps {
                sh "mvn clean"
            }
        }
        stage('Testing') {
            steps {
                sh "mvn test"
            }
        }
        stage('Package') {
            steps {
                sh "mvn package"
            }
        }
        stage('Copy Artifactory') {
            steps {
                sh "aws s3 cp $WORKSPACE/webapp/target/webapp.war s3://lwp-b72-morning-batch/"
            }
        }
        
        stage('Copy .War file to Docke Engine') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'docker', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd  /opt/docker; 
docker stop lwplabs && docker rm lwplabs ;
docker rmi vedantdevops/lwplabs:v1 ;
docker build -t vedantdevops/lwplabs:v1 . ;
docker run -d --name lwplabs -p 8080:8080 vedantdevops/lwplabs:v1
''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: 'webapp/target/', sourceFiles: 'webapp/target/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                }
        }
    }
}
