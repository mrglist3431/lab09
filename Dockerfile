FROM ubuntu:22.04

# Установка зависимостей
RUN apt update && apt install -yy \
    gcc \
    g++ \
    cmake \
    git \
    make \
    pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Рабочая директория
WORKDIR /app

# Копируем всю структуру проекта
COPY . .

# Очистка перед сборкой
RUN rm -rf build CMakeCache.txt CMakeFiles

# Сборка проекта
RUN mkdir -p build && \
    cd build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTS=OFF && \
    cmake --build . --target demo --parallel $(nproc) && \
    cmake --install .

# Проверка
RUN test -f /usr/local/bin/demo || (echo "Error: demo executable not found!" && exit 1)

# Настройка окружения
RUN chmod +x /usr/local/bin/demo && \
    mkdir -p /home/logs && \
    chmod 777 /home/logs

ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs

WORKDIR /usr/local/bin
ENTRYPOINT ["/usr/local/bin/demo"]
