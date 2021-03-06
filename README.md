Vertex
===============================

Weekly review service for GTD

Setup
-------------------------------

copy dot.env to .env, and edit it.

#### DEVISE\_SECRET\_KEY

Generate secret key

```
bundle exec rake secret
```

#### OMNIAUTH\_PROVIDER, OMNIAUTH\_ARGS

For example, omniauth-twitter needs an initializer as follows:
```ruby
Devise.setup do |config|
  config.omniauth :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
```

then you should set environment variables as follows:
```
OMNIAUTH_PROVIDER=twitter
OMNIAUTH_ARGS="['CONSUMER_KEY','CONSUMER_SECRET']"
```

See [config/initializers/devise.rb](https://github.com/codefirst/vertex/blob/master/config/initializers/devise.rb)

#### run

    $ yarn build # or yarn dev for developers
    $ bundle install --path .bundle
    $ bundle exec rake db:migrate
    $ bundle exec rails s

### Task

notify for all users by command

```
# notify immediately
$ bundle exec thor notification:notify
# per user
$ bundle exec thor notification:notify nickname

# notify by user's schedule setting
$ bundle exec thor notification:cron_notify
# per user
$ bundle exec thor notification:cron_notify nickname
```

License
-------------------------------
[The MIT License (MIT)](http://opensource.org/licenses/mit-license)
Copyright (c) 2014 codefirst
