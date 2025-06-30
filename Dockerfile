FROM node:18-alpine AS builder
WORKDIR /app
ENV DATABASE_URL="file:local.db"

COPY package.json package-lock.json ./
RUN npm config set registry https://registry.npmjs.org/ --global

#RUN --network=host npm ci
RUN npm ci

COPY . .
RUN npm run build

FROM node:18-alpine AS runtime
WORKDIR /app
ENV DATABASE_URL="file:local.db"

COPY package.json package-lock.json ./
RUN npm ci

COPY src ./src

ENV DATABASE_URL="file:local.db"

COPY --from=builder /app/build ./build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "build/index.js"]
