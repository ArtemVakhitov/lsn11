pipeline {
  agent {

    docker {
      image 'artemvakhitov/dind:latest'
      args '-v /root/.ssh:/root/.ssh'
    }

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
        sh 'wget https://github.com/ArtemVakhitov/lsn11/raw/main/Dockerfile'
        sh 'docker login --username artemvakhitov --password $dkrpass'
        sh 'docker build -t lsn11 .'
        sh 'docker tag dind artemvakhitov/lsn11 && docker push artemvakhitov/lsn11'

      }
    }

    stage('run docker on prod') {
      steps {
        sh 'ssh-keyscan -H $prod >> ~/.ssh/known_hosts'
        sh '''ssh $prod << EOF
	sudo docker run -d -p 8080:8080 artemvakhitov/lsn11
EOF'''
      }
    }
}