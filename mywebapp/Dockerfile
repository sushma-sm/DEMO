FROM debian:11

# Install Java (openjdk-11)
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Download and extract Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz /opt/

# Extract Tomcat archive manually (if ADD does not extract it)
RUN tar -xvzf /opt/apache-tomcat-9.0.98.tar.gz -C /opt/ && \
    mv /opt/apache-tomcat-9.0.98 /opt/tomcat

# Set working directory
WORKDIR /opt/tomcat

# Expose the port Tomcat will run on
EXPOSE 8080

#copy war file
COPY ./mywebapp.war/ opt/tomcat/webapps

# Start Tomcat
CMD ["./bin/catalina.sh", "run"]
