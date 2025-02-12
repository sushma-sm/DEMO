# Build stage: Use Maven with OpenJDK 17 to build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory inside the container for the build process
WORKDIR /app

# Copy the Maven configuration file (pom.xml) to the container
COPY pom.xml .

# Download and cache all project dependencies to speed up subsequent builds
RUN mvn dependency:resolve

# Copy the entire source code into the container
COPY src ./src

# Build the application and create a package, skipping tests to save time during the build
RUN mvn clean package -DskipTests

# Runtime stage: Use a lightweight OpenJDK 17 JRE for running the built application
FROM eclipse-temurin:17-jre-jammy

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built JAR file from the build stage to the runtime container
COPY --from=build /app/target/demo-1.0-SNAPSHOT.jar app.jar

# Expose port 8080 to allow access to the application
EXPOSE 8080

# Define the command to run the application using the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
