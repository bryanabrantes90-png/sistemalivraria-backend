# Imagem oficial do Maven com JDK 22 (funciona perfeitamente, não precisa instalar nada)
FROM maven:3.9.6-eclipse-temurin-22 AS build

# Pasta de trabalho
WORKDIR /app

# Copia o arquivo de dependências e o código
COPY pom.xml .
COPY src ./src

# Compila o projeto e gera o arquivo .jar
RUN mvn clean package -DskipTests

# Imagem menor só para rodar a aplicação
FROM eclipse-temurin:22-jre

WORKDIR /app

# 🔴 CORREÇÃO AQUI: copia o nome do .jar que realmente é gerado (backend-0.0.1-SNAPSHOT.jar)
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar app.jar

# Porta que o Railway vai usar
EXPOSE 8085

# Comando para iniciar
ENTRYPOINT ["java", "-jar", "app.jar"]