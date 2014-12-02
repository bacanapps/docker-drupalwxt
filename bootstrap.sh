#!/bin/bash
if [ ! -f app/sites/default/settings.php ]; then
  # Apache Settings
  # sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/default
  # a2enmod rewrite vhost_alias

  # Install Drupal WxT
  cd app
  drush si wetkit wetkit_theme_selection_form.theme=wetkit_bootstrap install_configure_form.demo_content=TRUE --root=/var/www/html --db-url=pgsql://super:wetkit2015@10.0.0.200:5432/drupalwxt --sites-subdir=default --account-name=admin --account-pass=wetkit2015 --yes

  sleep 5s
fi
supervisord -n
