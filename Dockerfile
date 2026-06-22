# Usamos imagem oficial do Maven com JDK 22 (já vem pronto, não precisa instalar nada)
FROM maven:3.9.6-eclipse-temurin-22 AS build

# Pasta de trabalho
WORKDIR /app

# Copia arquivos do projeto
COPY pom.xml .
COPY src ./src

# Compila o projeto e gera o JAR
RUN mvn clean package -DskipTests

# Imagem menor só para rodar (só o necessário)
FROM eclipse-temurin:22-jre

WORKDIR /app

# 🔴 NOME DO JAR CORRETO: backend-0.0.1-SNAPSHOT.jar
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar app.jar

# Porta do Railway
EXPOSE 8080

# Comando para rodar
ENTRYPOINT ["java", "-jar", "app.jar"]