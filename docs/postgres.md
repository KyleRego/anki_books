# Postgres

PostgreSQL is the object-relational database management system used by Anki Books. It is open-source and has [excellent documentation](https://www.postgresql.org/docs/14/index.html).

## Setup

Use this command to install PostgreSQL on Ubuntu:

```
sudo apt install postgresql
```

After installing this, you should create a database user for yourself.

You can connect to the database server `postgres` using the client CLI `psql` as the user `postgres`:

```
sudo -u postgres psql
```

Using the `psql` shell:

```
CREATE USER your_name;
ALTER USER your_name WITH CREATEDB;
\du
\q
```

Then with the current working directory being the root of the Rails code base, use this command to create the test and development environment databases:

```
bin/rails db:create
```

To run the migrations which set up the database schema:

```
bin/rails db:migrate
```

Finally, seed the database:

```
bin/rails db:seed
```

## Starting the server

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
