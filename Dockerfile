FROM drupalwxt/docker-apache-php:latest
MAINTAINER William Hearn <sylus1984@gmail.com>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor pwgen && \
  apt-get -y install mysql-client && \
  apt-get -y install postgresql-client

# Download Drupal WxT 2.x into /app
RUN rm -fr /app && mkdir /app && cd /app && \
  curl -O http://ftp.drupal.org/files/projects/wetkit-7.x-2.x-dev-core.tar.gz && \
  tar -xzvf wetkit-7.x-2.x-dev-core.tar.gz && \
  rm wetkit-7.x-2.x-dev-core.tar.gz && \
  mv wetkit-7.x-2.x-dev/* wetkit-7.x-2.x-dev/.htaccess ./ && \
  mv wetkit-7.x-2.x-dev/.gitignore ./ && \
  rmdir wetkit-7.x-2.x-dev

# Install composer and drush
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:6.*
RUN ln -sf /.composer/vendor/drush/drush/drush /usr/bin/drush

#Config and set permissions for setting.php
RUN cp app/sites/default/default.settings.php app/sites/default/settings.php && \
    chmod a+w app/sites/default/settings.php && \
    chmod a+w app/sites/default

EXPOSE 80

CMD exec supervisord -n
