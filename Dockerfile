FROM eclipse-temurin:22-jdk-jammy
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y maven
RUN mvn clean package -DskipTests
EXPOSE 10000
CMD ["java", "-jar", "-Dserver.port=10000", "-Dserver.address=0.0.0.0", "target/backend-0.0.1-SNAPSHOT.jar"]