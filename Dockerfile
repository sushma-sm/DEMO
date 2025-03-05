# Build stage: Use Maven with OpenJDK 17 to build the application
FROM --platform=linux/amd64 maven:3.8.4-openjdk-17 AS build

# Set the working directory inside the container for the build process
WORKDIR /app

# Copy the Maven configuration file (pom.xml) and resolve dependencies first (caching optimization)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire source code into the container
COPY src ./src

# Build the application and create a package, skipping tests to save time during the build
RUN mvn clean package -DskipTests

# Runtime stage: Use a lightweight OpenJDK 17 JRE for running the built application
FROM --platform=linux/amd64 eclipse-temurin:17-jre-jammy

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built JAR file from the build stage to the runtime container
COPY --from=build /app/target/demo-1.0-SNAPSHOT.jar app.jar

# Expose port 8080 for application access
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]
