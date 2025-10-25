# ---------- Build stage ----------
    FROM node:20-alpine AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm ci
    COPY . .
    RUN npm run build   
        
    # ---------- Run stage ----------
    FROM nginx:alpine
    COPY nginx.conf /etc/nginx/conf.d/default.conf
        COPY package.json package-lock.json ./
        RUN npm install
        COPY . .
        RUN npm run build