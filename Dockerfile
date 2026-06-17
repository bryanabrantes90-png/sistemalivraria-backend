# Imagem válida e existente (resolvendo o erro anterior)
FROM eclipse-temurin:22-jdk-jammy

# Define pasta de trabalho
WORKDIR /app

# Copia arquivos do projeto
COPY pom.xml .
COPY src ./src

# Instala o Maven
RUN apt-get update && apt-get install -y maven

# Compila o projeto, ignorando testes
RUN mvn clean install -DskipTests

# Copia o arquivo executável gerado
COPY target/*.jar app.jar

# Porta que a aplicação usa
EXPOSE 8085

# Comando para iniciar
CMD ["java", "-jar", "app.jar"]