# Imagem válida e compatível
FROM eclipse-temurin:22-jdk-jammy

# Define pasta de trabalho
WORKDIR /app

# Instala o Maven primeiro
RUN apt-get update && apt-get install -y maven

# Copia arquivos
COPY pom.xml .
COPY src ./src

# Compila o projeto
RUN mvn clean package -DskipTests

# Porta que o Render espera
EXPOSE 10000

# Comando de inicialização (com variáveis garantidas)
CMD ["java", "-jar", "-Dserver.port=10000", "target/backend-0.0.1-SNAPSHOT.jar"]