# Deployment

- `pg_dump -U <username> -W -F tar -d <database_name> -f <date>_anki_books_backup.tar`
- `git fetch`
- `git pull`
- `bundle install`
- `RAILS_ENV=production bundle exec rails db:migrate`
- `rails assets:precompile`
- `passenger-config restart-app`
- `sudo service apache2 restart`

`RAILS_ENV=production bundle exec passenger start` if the Passenger application server was not already running.

Note that `apache2.conf` and `ankibooks.io.conf` have absolute file path references to the Ruby interpreter and Passenger gem that will need to be updated if newer versions of these are used.

## Tips for setting up Anki Books on a home server:

- Flash a USB (recommended at least 16 Gb) with Ubuntu and use it to install Ubuntu on an old laptop.
- Set up a port forwarding rule for port 22 (SSH) on your gateway router to your new Ubuntu server.
- Open port 22 on the machine with `ufw` (Uncomplicated Firewall, a frontend for managing firewall rules).
  - Test that you can login to your user on the machine remotely using SSH and set up SSH keys (recommended).
- Install the Apache web server on the machine and test that you can see the Apache test page by visiting the IP address.
  - At this time you might replace that `index.html` with something else since it may give away your server's operating system and Apache version.
- Buy a domain name and get a digital certificate.
  - If your IP address is dynamic, get an A+ Dynamic DNS record. There are ways to update the DNS record if your IP address changes (this can happen when your gateway router restarts, for example).
- Set up a port forwarding rule for port 443 (HTTPS) and possibly 80 as well (HTTP), and open these ports on the firewall with `ufw`.
- Configure Apache.
  - Test that you can see the Apache test page by visiting your domain name over HTTPS.
- Pull the Rails application to the server and set up the Postgres database.
  - Set up the `credentials.yml.enc` to store the database password and storage path.
- Configure Apache/Passenger to serve the Rails application.
  - Install passenger as a system gem (`gem install passenger`) and execute the `passenger-install-apache2-module` command to have it walk you through most of the steps.
- Test that you can see the Rails application on your domain name over HTTPS.

The server will also need libvips installed:

```
sudo apt-get install libvips libvips-tools
```
