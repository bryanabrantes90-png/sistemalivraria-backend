FROM eclipse-temurin:22-jdk-jammy

WORKDIR /app

COPY pom.xml .
RUN apt-get update && apt-get install -y maven
RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

EXPOSE 8085

CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]