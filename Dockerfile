FROM bitnami/php-fpm:7.4.20-prod-debian-10-r1

RUN install_packages php-mysql
WORKDIR /app
ADD install-composer.sh /app/
RUN /app/install-composer.sh

ADD composer.json /app/

RUN cd /app \
  && composer install
RUN mkdir web/sites/default/files \
  && chmod -R 774 web/sites/default/files \
  && chgrp -R daemon web/sites/default/files

ADD config/drupal/settings.php web/sites/default/settings.php

ENV PATH="/app/vendor/bin:$PATH"
