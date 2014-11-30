Drupal
======

Drupal docker image without a DB included in the image. This image is designed to be used with drupalwxt/mysql or similar stand-alone DB image in order to create a multi-container cluster.

On docker run, browse to Port 80 on the container to complete initial setup.
Example usage:

`$ docker run --rm --name DRUPAL --link DB:DB drupalwxt/drupalwxt:latest`

...where `DB:DB` matches the name and alias of your DB instance. Use the values from your linked DB image to complete GUI setup.
