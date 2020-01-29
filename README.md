# Running Custom Drupal in Containers

The first time the container is brought up, it will install Drupal if it does not detect an existing database.
Otherwise, the container will connect to an existing install without disrupting data.

Locally, map the project directory to `/bitnami` to copy up application files to the container.
In live environments, this should be a managed volume according to the platform being used.
Environment variables are utilized by the Bitnami init scripts to populate the `settings.php` file.

Get started:

```bash
docker-compose up -d
```
