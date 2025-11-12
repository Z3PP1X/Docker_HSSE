FROM nginx:stable-alpine
LABEL maintainer="z3pp1x"

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

COPY hsse.conf /etc/nginx/nginx.conf

# Security headers config
COPY security-headers.conf /etc/nginx/conf.d/security-headers.conf

# Fix permissions for existing nginx user
RUN chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
