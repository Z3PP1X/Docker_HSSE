# === Stage 1: Build Angular Application ===
FROM node:20-slim AS builder

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

ARG RELEASE_VERSION=v1.0-stable

WORKDIR /app

RUN git clone https://github.com/Z3PP1X/HSSE_Webpage_FE.git

WORKDIR /app/HSSE_Webpage_FE/frontend

RUN git checkout ${RELEASE_VERSION}

COPY /build/environment.prod.ts ./src/environments/environment.prod.ts

RUN npm install && \
    npm install -g @angular/cli

CMD ["sleep", "infinity"]


#RUN ng build frontend --configuration=production --output-path=./dist

# === Stage 2: PRODUKTION
#FROM nginx:alpine

#COPY --from=builder /app/HSSE_Webpage_FE/dist/your-project-name/browser /usr/share/nginx/html

#EXPOSE 80

