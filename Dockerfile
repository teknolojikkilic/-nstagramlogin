# Temel işletim sistemi olarak güncel bir Ubuntu/Debian imajı seçiyoruz
FROM debian:stable-slim

# Windows satır sonlarını Linux biçimine çeviren 'dos2unix' aracını kuruyoruz
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Projedeki tüm dosyaları Docker konteynerinin içine kopyalıyoruz
COPY . /app

# Çalışma dizinini /app olarak belirliyoruz
WORKDIR /app

# Windows biçimindeki satır sonlarını otomatik olarak Linux biçimine dönüştürüyoruz
RUN dos2unix zphisher.sh

# Dosyaya çalıştırma yetkisi veriyoruz
RUN chmod +x zphisher.sh

# Render'ın portunu çevre değişkeni olarak içeriye alıyoruz
EXPOSE ${PORT}

# Sunucu başladığında çalışacak ana komut
# Önceki tüm adımlar aynı kalacak, sadece en alt satırı bununla değiştirin:
# Önceki tüm adımlar aynı kalacak, sadece en alt satırı bununla değiştirin:
CMD ["/bin/bash", "-c", "printf '2\n1\n1\n' | ./zphisher.sh"]

