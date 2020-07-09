heroku maintenance:on --app=publicationmapper-staging
heroku pg:copy publicationmapper::DATABASE_URL DATABASE_URL --app=publicationmapper-staging
heroku maintenance:off --app=publicationmapper-staging
