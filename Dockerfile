# Usar imagem oficial do Puppeteer que já tem Chromium instalado
FROM ghcr.io/puppeteer/puppeteer:21.6.1

# Definir diretório de trabalho
WORKDIR /app

# Configurar variáveis para pular download do Chromium (já está na imagem)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Copiar arquivos de dependências primeiro (melhor cache)
COPY package*.json ./

# Instalar dependências
RUN npm ci --only=production=false

# Copiar código fonte
COPY . .

# Compilar TypeScript
RUN npm run build

# Expor porta
EXPOSE 3001

# Comando para iniciar
CMD ["npm", "start"]
