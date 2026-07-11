FROM debian:stable-slim

# Temel araçların yanına 'expect' paketini de ekliyoruz
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    dos2unix \
    expect \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

RUN dos2unix zphisher.sh
RUN chmod +x zphisher.sh

EXPOSE ${PORT}

# Doğrudan bash çalıştırmak yerine, aşağıda oluşturacağımız otomasyon script'ini tetikliyoruz
CMD ["expect", "otomasyon.expect"]
