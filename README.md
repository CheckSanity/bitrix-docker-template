# Bitrix docker template

**Important**: This template is intended for debugging, testing, or staging purposes only and is not production-ready.
Ensure you perform thorough security and performance assessments and enhance the solution to meet your specific
requirements before using it in a production environment.

## Before you start

- Install Docker and Docker Compose

## Setup

1. **Bitrix Container**:
    - `site/public`: Place your `public` folder here or root of the Bitrix inside it. It includes bitrix, index.php and
      all
      other files

2. **Database Container**:
    - `mysqldumps/backup.sql`: Put your production database snapshot here. It's imported automatically on first run.
    - `init/migrate.sh`: Database migration script, runs automatically
    - `database` volume will be located under `./database`

3. **Environment**

   Copy `.env.template` to `.env` file in project root folder. Adjust required parameters

    - `COMPOSE_PROJECT_NAME` (required): Your project name for Docker and Docker Compose
    - `DOMAIN` (required): URL for your site
    - `INTERFACE` (required): Host
    - `DB_NAME` (required): Bitrix database name. e.g. `bitrix`
    - `DB_USER` (required): Bitrix database user. e.g. `bitrix`
    - `DB_PASSWORD` (required): Bitrix database password. e.g. `db_pass`
    - ...

4. **Running**

```bash
docker-compose up -d
```

**Note**: Importing a database from an SQL dump can take some time, depending on the size of the file. Please be patient
and, if needed, monitor the database container logs for updates or potential issues.

## Access site

Access your site at `http://localhost`.

## Access database

Access Adminer to manage database at `http://localhost:8080`

- Server - <COMPOSE_PROJECT_NAME>_database
- Username - <DB_USER> e.g. bitrix
- Password - <DB_PASSWORD> e.g db_pass
- Database - <DB_NAME> e.g. bitrix

## Notes

This version is created for specific project. Please update PHP and MySQL version on your needs.
Right now using:

- `PHP 8.1`
- `MySQL 8.0.36`

## Credits

Based on [bitrix-docker](https://github.com/snezhig/bitrix-docker/)
