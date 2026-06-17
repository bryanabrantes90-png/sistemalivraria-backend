# Imagem oficial, existente e compatível com Java 22
FROM eclipse-temurin:22-jdk-jammy

# Define a pasta de trabalho
WORKDIR /app

# 🔹 Copia primeiro o pom.xml para aproveitar cache do Docker
COPY pom.xml .

# 🔹 Instala o Maven (obrigatório na imagem slim)
RUN apt-get update && apt-get install -y maven

# 🔹 Baixa dependências (separado para cache)
RUN mvn dependency:go-offline -B

# 🔹 Copia o código fonte
COPY src ./src

# 🔹 Compila o projeto, ignorando testes
RUN mvn clean package -DskipTests

# 🔹 Porta que o Railway usa automaticamente
EXPOSE 8085

# 🔹 Comando de inicialização CORRETO
CMD ["java", "-jar", "target/sistemalivraria-backend-0.0.1-SNAPSHOT.jar"]