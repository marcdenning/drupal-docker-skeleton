FROM bitnami/drupal:8

ADD composer.json /bitnami/

RUN cd /bitnami \
  && composer install
