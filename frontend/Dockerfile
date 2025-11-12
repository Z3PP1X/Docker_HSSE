FROM nginx:alpine

# Tools zum Download und Entpacken
RUN apk add --no-cache curl unzip

# Version/Release anpassen
ENV RELEASE_VERSION=v1.0.0
ENV ASSET_URL=https://github.com/Z3PP1X/HSSE_Webpage_FE/releases/download/${RELEASE_VERSION}/frontend.zip

# Release herunterladen und nach /usr/share/nginx/html entpacken
RUN curl -L $ASSET_URL -o frontend.zip && \
    unzip frontend.zip -d /usr/share/nginx/html && \
    rm frontend.zip

# Nginx konfigurieren
RUN echo 'server { \
    listen 80; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
