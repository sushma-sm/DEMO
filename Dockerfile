# Use an official OpenJDK image
FROM openjdk:17-jdk-slim  

# Set the working directory
WORKDIR /app  

# Copy the built JAR file
COPY target/myapp.jar app.jar  

# Expose the application port
EXPOSE 8080  

# Run the application
CMD ["java", "-jar", "app.jar"]  
