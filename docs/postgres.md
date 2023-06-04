# Postgres

This command starts the PostgreSQL database server:

```
sudo service postgresql start
```

It is probably best to add an alias for this command. With Ubuntu, adding the following to the `.bashrc` creates the alias when the Bash shell starts:

`alias startpg='sudo service postgresql start'`

## UUIDs

The current design is to use only UUIDs for primary keys.

## pgcrypto

The following line in the `CreateArticles` migration enables the `ppgcrypto` PostgreSQL extension:

```
enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
```

## Backups

Use the `pg_dump` command to create a backup of the database:

```
pg_dump -U <username> -W -F tar -d <database_name> -f 4_20_2023_anki_books_backup.tar
```
