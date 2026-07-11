FROM debian:stable-slim

# Gerekli tüm araçları ve arka plan sunucusu için python3 paketini kuruyoruz
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

# Render'ın beklediği portu dışarıya tanımlıyoruz
EXPOSE ${PORT}

# Arka planda hem boş bir HTTP sunucusu açıyoruz hem de otomasyonu başlatıyoruz
CMD python3 -m http.server ${PORT} & expect otomasyon.expect
FROM debian:stable-slim

# Gerekli tüm araçları ve arka plan sunucusu için python3 paketini kuruyoruz
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

# Render'ın beklediği portu dışarıya tanımlıyoruz
EXPOSE ${PORT}

# Arka planda hem boş bir HTTP sunucusu açıyoruz hem de otomasyonu başlatıyoruz
CMD python3 -m http.server ${PORT} & expect otomasyon.expect
