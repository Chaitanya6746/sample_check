FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/service_discovery-0.0.1-SNAPSHOT.jar service_discovery.jar

EXPOSE 8761

ENTRYPOINT ["java","-jar","service_discovery.jar"]