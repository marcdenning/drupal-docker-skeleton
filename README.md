# Drupal Docker Skeleton

> A sample repo intended to be cloned for starting a new Drupal 9+ site.

## Get started

```bash
docker compose up -d
aws --endpoint-url=http://localhost:4566 s3 mb s3://drupalfiles # Use the localstack container to create a local AWS S3 bucket
```

## Install Drupal

The first time the Drupal container is started in a new Docker environment with an empty database, the app must be installed.

Use this script to launch into a bash session with Docker Compose to install Drupal via Drush and export the `settings.php` file.

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

Update `settings.php` to configure `trusted_host_patterns` and file system settings:

```php
$settings['file_private_path'] = '/app/private';

$settings['trusted_host_patterns'] = [
  '^drupal.local$',
];

$settings['s3fs.access_key'] = 'accesskey';
$settings['s3fs.secret_key'] = 'secretkey';
$settings['s3fs.use_s3_for_public'] = TRUE;
$settings['s3fs.use_s3_for_private'] = TRUE;
$settings['php_storage']['twig']['directory'] = '/app/private';
```

## Configuration Management

Drupal's [Configuration Management](https://www.drupal.org/docs/configuration-management) system allows site configuration, entity types, views, and other system elements to be exported and imported via YAML files.

After making changes in a lower environment (including local), export changes with:

```bash
drush config:export
```

Commit any changes to version control.

When deploying changes, import configuration updates with:

```bash
drush config:import
```
