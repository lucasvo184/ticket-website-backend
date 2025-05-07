# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy the entire project
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app

# Add curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the built jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port
EXPOSE ${PORT:-8080}

# Set environment variables for Java
ENV JAVA_OPTS="-Xmx512m -Xms256m -Dserver.port=${PORT:-8080} -Dlogging.level.root=DEBUG -Dlogging.level.org.springframework=DEBUG -Dlogging.level.com.example.bookingTicket=DEBUG"

# Add health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:${PORT:-8080}/actuator/health || exit 1

# Run the application with debug logging
ENTRYPOINT ["sh", "-c", "echo 'Starting application on port: '${PORT:-8080} && java $JAVA_OPTS -jar app.jar --debug"]
