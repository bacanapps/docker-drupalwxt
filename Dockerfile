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
RUN ln -s /usr/local/bin/composer /usr/bin/composer
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
RUN cd /usr/local/src/drush && \
    git checkout 6.5.0 && \
    ln -s /usr/local/src/drush/drush /usr/bin/drush && \
    composer install && \
    drush --version

# Config and set permissions for setting.php
RUN chmod a+w app/sites/default/settings.php && \
    chmod a+w app/sites/default && \
    mkdir app/sites/default/files && \
    chown -R www-data:www-data app/

# Scripts
ADD ./bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

EXPOSE 80

# Run Time
CMD ["/bin/bash", "/bootstrap.sh"]
