pipeline {

  agent {

    docker {
      image 'artemvakhitov/dind:alpine'
      args '-v /root/.ssh:/root/.ssh -v /var/run/docker.sock:/var/run/docker.sock'
    }

  }

  environment {
    DOCKER_PASSWORD = credentials('dkrpass')
    BRANCH_NAME = "${env.GIT_BRANCH.replaceFirst(/^origin\//, '')}"
  }

  stages {

    stage('git') {
      steps {
        git 'https://github.com/boxfuse/boxfuse-sample-java-war-hello.git'
      }
    }

    stage('build war') {
      steps {
        sh 'mvn package'
      }
    }

    stage('make docker image') {
      steps {
        sh 'wget https://raw.githubusercontent.com/artemvakhitov/lsn11/$BRANCH_NAME/Dockerfile'
        sh 'docker login --username artemvakhitov --password $DOCKER_PASSWORD'
        sh 'docker build -t lsn11 .'
        sh 'docker tag lsn11 artemvakhitov/lsn11 && docker push artemvakhitov/lsn11'

      }
    }

    stage('run docker on prod') {
      steps {
        sh 'ssh-keyscan -H $prod >> ~/.ssh/known_hosts'
        sh 'ssh $prod docker run -d -p 8080:8080 artemvakhitov/lsn11'
      }
    }
  }
}