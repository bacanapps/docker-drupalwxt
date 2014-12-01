#!/bin/bash
if [ ! -f app/sites/default/settings.php ]; then
  cd app
  drush si wetkit wetkit_theme_selection_form.theme=wetkit_bootstrap install_configure_form.demo_content=TRUE --db-url=pgsql://super:wetkit2015@10.0.0.200:5432/drupalwxt --sites-subdir=default --account-name=admin --account-pass=wetkit2015 --site-name="WxT" —-yes
  sleep 5
fi
supervisord -n
