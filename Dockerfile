FROM eclipse-temurin:22-jdk-jammy

WORKDIR /app

COPY pom.xml .
RUN apt-get update && apt-get install -y maven
RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

EXPOSE 8085

# ✅ COMANDO COM MAIS VERBOSIDADE PARA VER ERRO
CMD ["java", "-jar", "-Dspring.profiles.active=prod", "target/backend-0.0.1-SNAPSHOT.jar"]