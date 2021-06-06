FROM bitnami/php-fpm:7.4.20-prod-debian-10-r1

WORKDIR /app
ADD install-composer.sh /app/
RUN /app/install-composer.sh

ADD composer.json /app/

RUN cd /app \
  && composer install
