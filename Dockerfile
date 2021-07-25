FROM bitnami/php-fpm:7.4.20-prod-debian-10-r1

RUN install_packages php-mysql
WORKDIR /app
ADD install-composer.sh /app/
RUN /app/install-composer.sh

ADD composer.json /app/

RUN cd /app \
  && composer install
RUN mkdir web/sites/default/files \
  && chmod -R 775 web/sites/default \
  && chgrp -R daemon web/sites/default \
  && mkdir sync private \
  && chgrp -R daemon sync private \
  && chmod -R 775 sync private

ADD config/drupal/sync /app/sync

ENV PATH="/app/vendor/bin:$PATH"
