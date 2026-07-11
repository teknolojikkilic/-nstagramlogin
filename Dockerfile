# Temel işletim sistemi olarak güncel bir Ubuntu/Debian imajı seçiyoruz
FROM debian:stable-slim

# Betiğinizin çalışması için gereken temel araçları (bash, curl vb.) kuruyoruz
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Projenizdeki tüm dosyaları Docker konteynerinin içine kopyalıyoruz
COPY . /app

# Çalışma dizinini /app olarak belirliyoruz
WORKDIR /app

# .sh dosyanıza çalıştırma yetkisi veriyoruz
RUN chmod +x zphisher.sh

# Render'ın portunu çevre değişkeni olarak içeriye alıyoruz
EXPOSE ${PORT}

# Konteyner başladığında çalışacak ana komut
CMD ["/bin/bash", "zphisher.sh"]
