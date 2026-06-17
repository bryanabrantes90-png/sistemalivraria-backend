# Usando imagem válida e existente
FROM openjdk:22-jdk-slim

# Define pasta de trabalho
WORKDIR /app

# Copia o arquivo pom.xml e código
COPY pom.xml .
COPY src ./src

# Instala o Maven dentro da imagem
RUN apt-get update && apt-get install -y maven

# Compila o projeto
RUN mvn clean install -DskipTests

# Copia o arquivo .jar gerado
COPY target/*.jar app.jar

# Porta que sua aplicação usa
EXPOSE 8085

# Comando para rodar
CMD ["java", "-jar", "app.jar"]