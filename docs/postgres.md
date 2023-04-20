# Postgres

This command starts the PostgreSQL database server:

```
sudo service postgresql start
```

I have found that this does not start automatically with WSL2/Ubuntu.

The command can be added to the `.bashrc` file (a shell script that executes every time you start a Bash shell), but since it requires elevated privileges, starting a Bash shell will now always prompt you for your password.

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
