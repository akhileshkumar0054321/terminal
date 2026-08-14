# =========================
# Build Frontend
# =========================
FROM node:20-alpine AS frontend-builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# =========================
# Build Backend
# =========================
FROM node:20-alpine

WORKDIR /app

COPY ./Backend/package*.json ./
RUN npm install

COPY ./Backend ./

# Copy frontend build into backend's public folder
COPY --from=frontend-builder /app/dist ./public

EXPOSE 3000

CMD ["node", "server.js"]