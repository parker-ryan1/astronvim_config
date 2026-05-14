#!/bin/bash
# Install script for top 20 programming languages (WSL Ubuntu)

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating apt..."
apt-get update

echo "==> Installing basic languages: C/C++, Python, JS/TS, Java, Go, Ruby, PHP, R, Lua, SQL..."
apt-get install -y --no-install-recommends \
    gcc g++ clang make cmake \
    python3 python3-pip python3-venv python3-dev \
    nodejs npm \
    default-jdk \
    golang-go \
    ruby-full \
    php-cli php-xml php-mbstring \
    r-base \
    lua5.4 \
    sqlite3 postgresql-client default-mysql-client \
    curl wget git unzip zip software-properties-common apt-transport-https

# Install global TypeScript execution
npm install -g npx tsx typescript

echo "==> Adding Microsoft Repo for .NET (C#)..."
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update
apt-get install -y dotnet-sdk-8.0

echo "==> Installing Rust..."
sudo -u "$SUDO_USER" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -u "$SUDO_USER" sh -s -- -y

echo "==> Installing Kotlin via SDKMAN..."
sudo -u "$SUDO_USER" bash -c 'curl -s "https://get.sdkman.io" | bash'
sudo -u "$SUDO_USER" bash -c 'source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install kotlin'

echo "==> Done installing compilers and interpreters!"
