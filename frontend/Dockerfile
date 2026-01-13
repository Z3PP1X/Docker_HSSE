# === Stage 1: Build Angular Application ===
FROM node:20-slim AS builder

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

ARG RELEASE_VERSION=main

WORKDIR /app

RUN git clone https://github.com/Z3PP1X/HSSE_Webpage_FE.git

WORKDIR /app/HSSE_Webpage_FE/frontend

RUN git checkout ${RELEASE_VERSION}

COPY /build/environment.prod.ts ./src/environments/environment.prod.ts

RUN npm install && \
    npm install -g @angular/cli

COPY /build/angular.json .

RUN ng build frontend --configuration=production --output-path=./dist

#CMD ["npm", "start", "--", "--host", "0.0.0.0"]

#EXPOSE 4200

# === Stage 2: PRODUKTION
FROM nginx:alpine

COPY --from=builder /app/HSSE_Webpage_FE/frontend/dist/browser /usr/share/nginx/html

EXPOSE 80



