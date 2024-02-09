FROM vedantdevops/tomcat:v1
COPY ./*.war /usr/local/tomcat/webapps
