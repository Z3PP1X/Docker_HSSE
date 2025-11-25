FROM nginx:alpine

# Tools zum Download und Entpacken
RUN apk add --no-cache curl unzip

# Version/Release anpassen
ARG RELEASE_VERSION=v1.0.0
ENV ASSET_URL=https://github.com/Z3PP1X/HSSE_Webpage_FE/releases/download/${RELEASE_VERSION}/frontend.zip

# WICHTIG: Zuerst die nginx-Default-Seite komplett löschen
RUN rm -rf /usr/share/nginx/html/*

# In tmp arbeiten
WORKDIR /tmp

# Release herunterladen und entpacken
RUN curl -L $ASSET_URL -o frontend.zip && \
    unzip frontend.zip && \
    cp -r frontend/browser/* /usr/share/nginx/html/

# Aufräumen
RUN rm -rf /tmp/*

# Nginx Config kopieren (NACH dem Löschen der Default-Files)
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
COPY nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]