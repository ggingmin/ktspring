FROM eclipse-temurin:11-jdk as builder
WORKDIR app
COPY gradlew .
COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootjar

FROM eclipse-temurin:11-jdk as extractor
WORKDIR app
ARG JAR_FILE=build/libs/*.jar
COPY --from=builder app/${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM eclipse-temurin:11-jre as runtime
WORKDIR app
ENV PORT 8080
COPY --from=extractor app/dependencies/ ./
COPY --from=extractor app/spring-boot-loader/ ./
COPY --from=extractor app/snapshot-dependencies/ ./
COPY --from=extractor app/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]