curl -o backup.dump `heroku pg:backups public-url --app publicationmapper`

pg_restore -U postgres --verbose --clean --no-acl --no-owner -d pubmap_dev ./backup.dump
