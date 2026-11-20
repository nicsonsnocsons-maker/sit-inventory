FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Копируем серверный JAR и данные реестра
COPY server.jar /app/
COPY equipment_current.csv /app/
COPY app_icon.png /app/
COPY qrcode.min.js /app/

# Создаем пользователя без root-прав (требование Hugging Face Spaces: UID 1000)
RUN useradd -m -u 1000 user && \
    mkdir -p /app/uploads/photos && \
    chown -R user:user /app

USER user

# Hugging Face слушает порт 7860, Render переопределяет через $PORT
ENV PORT=10000
EXPOSE 10000

CMD ["java", "-Dfile.encoding=UTF-8", "-jar", "server.jar"]
