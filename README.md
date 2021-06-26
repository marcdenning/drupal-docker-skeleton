# Drupal Docker Skeleton

> A sample repo intended to be cloned for starting a new Drupal 9+ site.

## Get started

```bash
docker compose up -d
```

## Install Drupal

```bash
docker compose exec drupal bash

# In the Drupal container
cd /app
drush site:install -y \
  --db-url=mysql://bn_drupal:bn_drupal@mariadb:3306/bitnami_drupal \
  --account-name=admin \
  --account-mail=your@email.com \
  --site-mail=your@email.com \
  minimal
chmod 644 web/sites/default/settings.php
exit

# Copy the generated settings.php file locally to be mounted as a "secret"
docker compose ps # Get the name of the Drupal container
docker cp container-name:/app/web/sites/default/settings.php ./config/drupal/settings.php # Copy the file to your local project directory
```
