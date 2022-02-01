FROM nginx:1.21.6-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN apk update \
  && apk add --no-cache openssl

RUN  openssl genrsa -out /etc/nginx/default.key 2048 \
  && openssl req -new -key "/etc/nginx/default.key" -out "/etc/nginx/default.csr" -subj "/CN=localhost/O=localhost/C=UK" \
  && openssl x509 -req -days 365 -in "/etc/nginx/default.csr" -signkey "/etc/nginx/default.key" -out "/etc/nginx/default.crt" \
  && chmod go+r /etc/nginx/default.key

WORKDIR /app/
