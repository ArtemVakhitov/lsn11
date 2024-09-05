FROM tomcat:8-alpine
ADD boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/