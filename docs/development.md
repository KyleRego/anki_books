# Development

## Ruby dependencies

The `Gemfile` specifies what gems are required by the application. With the Bundler package manager, `bundle install` will download and install the gems and their gem dependencies.

## System dependencies

The application uses libvips which is needed by Active Storage for images:

```
sudo apt-get install libvips libvips-tools
```

## The database

The application uses a PostgreSQL database. The `config/database.yml` file has the configuration settings. Executing `rails db:create` should create the databases specified in that file. Pending migrations are run with `rails db:migrate`. 

## The bin/dev script

The `bin/dev` script starts the development environment. It installs the foreman gem if it was not already installed and then uses the `foreman` command to start the processes specified in `Procfile.dev` (a process for the Rails server and a process to watch for changes in CSS files and recompile them using Tailwind).

If you are using RVM to manage Ruby versions, it's possible this script will throw this error:

```
~/.rvm/gems/ruby-3.2.1/bin/foreman: 6: exec: ~/.rvm/gems/ruby-3.2.1/bin/ruby: not found
```

In my case, this was due to the Ruby executable being missing from the directory specified in `$PATH`. I was able to fix the issue with `rvm remove 3.2.1` and `rvm install 3.2.1`.

If you need to debug further, `echo $PATH | tr ':' '\n'` will print the `$PATH` variable with each directory on its own line.

## TailwindCSS

The Tailwind CSS IntelliSense VS Code extension makes working with Tailwind even nicer. Add the suggested mapping between plaintext and html in the extension settings to enable it for ERB files.
