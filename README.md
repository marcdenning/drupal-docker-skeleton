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
chmod 774 web/sites/default/settings.php
chgrp daemon web/sites/default/settings.php
drush site:install -y minimal
```
