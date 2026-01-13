# === Stage 1: Build Angular Application ===
FROM node:20-slim AS builder

# Install git with minimal footprint
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Build arguments for branch/version selection
ARG GIT_BRANCH=main
ARG REPO_URL=https://github.com/Z3PP1X/HSSE_Webpage_FE.git

# Set build-time labels
LABEL org.opencontainers.image.source="${REPO_URL}"
LABEL org.opencontainers.image.version="${GIT_BRANCH}"

WORKDIR /app

# Clone with shallow depth for faster builds (branch-specific)
RUN git clone --depth 1 --branch ${GIT_BRANCH} ${REPO_URL} source

WORKDIR /app/source/frontend

# Install dependencies first (better layer caching if package.json unchanged)
COPY /build/package-lock.json* ./
RUN npm ci --prefer-offline --no-audit || npm install

# Install Angular CLI globally (pinned version for consistency)
RUN npm install -g @angular/cli@17

# Copy environment config AFTER npm install (faster rebuilds)
COPY /build/environment.prod.ts ./src/environments/environment.prod.ts

# Copy custom angular.json if needed
COPY /build/angular.json ./

# Build with production configuration
RUN ng build --configuration=production --output-path=./dist

# === Stage 2: Production Nginx Server ===
FROM nginx:alpine

# Security: Run as non-root
RUN chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Copy built Angular app 
# Note: Angular 17+ outputs to dist/browser by default
COPY --from=builder /app/source/frontend/dist/browser /usr/share/nginx/html

# Copy custom nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Security headers
RUN echo 'add_header X-Frame-Options "SAMEORIGIN" always;' >> /etc/nginx/conf.d/security.conf && \
    echo 'add_header X-Content-Type-Options "nosniff" always;' >> /etc/nginx/conf.d/security.conf

USER nginx

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
