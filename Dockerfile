# Use official OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file from target/
COPY target/AccountService-0.0.1-SNAPSHOT.jar app.jar

# Expose port (match application.properties)
EXPOSE 8090

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]