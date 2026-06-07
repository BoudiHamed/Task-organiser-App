FROM node:24.10.0-alpine AS builder
WORKDIR /app
COPY package*.json .
COPY prisma ./prisma
RUN npm install
RUN npx prisma generate

FROM node:24.10.0-alpine
WORKDIR /app
COPY package*.json .
RUN npm install --omit=dev
COPY --from=builder /app/src/generated ./src/generated
COPY . .

EXPOSE 3000
CMD ["node", "src/server.js"]
