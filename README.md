# MovieCatalog 

The projects creates just a webpage where you can catalog your prefered movies.

## Dependencies

You need to install these services and ensure they are running on your machine

- PostgreSQL 9.3+ (probably more, but tested only on (9.3)
- Elasticsearch

## How to run

1. Ensure you have all environment variables set. All variables that are needed, can be found on `.env.sample` file

2. Install the gems with `bundle install`
3. Prepare database with `rake db:setup`
4. Create the elasticsearch indexes with
```ruby
bundle exec rake environment elasticsearch:import:model CLASS=Movie FORCE=y
```

5. **Optional:** feed the database with some data, running:
```ruby
# #{start}` and #{finish} shall be a 4 digit number
# obviously with start < finish
rake db:seed seed_from=#{start} seed_to=#{finish}
```

6. run the app with `bundle exec rails s`

7. Enjoy :)

