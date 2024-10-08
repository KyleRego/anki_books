# Development

## Ruby dependencies

The `Gemfile` specifies what Ruby gems are required by the application. With the Bundler package manager, `bundle install` will download and install the gems and their gem dependencies.

## System dependencies

The application uses libvips which is needed by Active Storage for images:

```
sudo apt-get install libvips libvips-tools
```

Also see postgres.md and testing.md.

## The database

The rails db:setup task creates the database, loads the schema from the current db/schema.rb (this is not the same as running all the migrations), and initializes it with the seed data from db/seeds.rb; the rails db:reset task will drop the database and set it up again.

The application uses a PostgreSQL database. The `config/database.yml` file has the configuration settings.

The homepage of the website is an article with system: true. This can be added with the `rails db:seed` task or the Rails console.

## The bin/dev script

The `bin/dev` script starts the development environment. First it runs the `rails assets:precompile` which compiles the front-end assets. Then it installs the Foreman gem if it was not already installed and then uses the `foreman` command to start the processes specified in `Procfile.dev` (a process for the Rails server and a process to watch for changes in CSS files and recompile them using Tailwind).

If you are using RVM to manage Ruby versions, it's possible this script will throw this error:

```
~/.rvm/gems/ruby-3.2.1/bin/foreman: 6: exec: ~/.rvm/gems/ruby-3.2.1/bin/ruby: not found
```

In my case, this was due to the Ruby executable being missing from the directory specified in `$PATH`. I was able to fix the issue with `rvm remove 3.2.1` and `rvm install 3.2.1`.

If you need to debug further, `echo $PATH | tr ':' '\n'` will print the `$PATH` variable with each directory on its own line.

## Overcommit

Overcommit is a gem being used to manage the Git hooks. It (hopefully) outputs something like the following when commiting a change:
```
Running pre-commit hooks
Analyze with RuboCop........................................[RuboCop] OK

✓ All pre-commit hooks passed

Running commit-msg hooks
Check for trailing periods in subject................[TrailingPeriod] OK
Check text width..........................................[TextWidth] OK
Check subject line................................[SingleLineSubject] OK
Check subject capitalization.....................[CapitalizedSubject] OK

✓ All commit-msg hooks passed
```

Changes to the `.overcommit.yml` file may require you to verify the changes and sign with `overcommit --sign`. This is a security mechanism since Git hooks could be used in general to do something malicious.
