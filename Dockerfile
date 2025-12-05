FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY app ./app

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app /app

FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
EXPOSE 8080
CMD ["node", "app/server.js"]

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

#FROM node:18-alpine
#WORKDIR /app
#COPY package*.json ./
#RUN npm install
#COPY app ./app
#EXPOSE 8080
#CMD ["node", "app/server.js"]
