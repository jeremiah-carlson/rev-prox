FROM nginx:1.23-alpine3.18

ENV SERVER_NAME="rev-prox.com"
ENV SSL_CERT=""
ENV SSL_PK=""

# Static Files
RUN mkdir /usr/local/www /usr/local/img
COPY ./app/* /usr/local/app/

# Get nginx configs
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/proxy.conf /etc/nginx/proxy.conf
COPY ./nginx/conf.d /etc/nginx/conf.d

# Get certs
RUN echo $SSL_CERT > /etc/ssl/certs/$SERVER_NAME.crt
RUN echo $SSL_PK > /etc/ssl/private/$SERVER_NAME.key

# Adjust Permissions
RUN chown -R nginx:nginx /usr/local/app
RUN chown nginx:nginx /etc/ssl/private/$SERVER_NAME.key
RUN chown nginx:nginx /etc/ssl/certs/$SERVER_NAME.crt