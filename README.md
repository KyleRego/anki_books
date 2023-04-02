# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

To start running the database in WSL2
```
sudo service postgresql start
```

TODOS
- Figure out issue with postgres needing to be started manually
  - This is probably due to systemd not being used as the init system
- Figure out issue with bin/dev script throwing an error