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

For example, omniauth-github needs an initializer as follows:
```ruby
Devise.setup do |config|
  config.omniauth :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
```

then you should set environment variables as follows:
```
OMNIAUTH_PROVIDER=github
OMNIAUTH_ARGS="['GITHUB_KEY','GITHUB_SECRET']"
```

See [config/initializers/devise.rb](https://github.com/codefirst/vertex/blob/master/config/initializers/devise.rb)

#### run

    $ bundle install --path .bundle
    $ bundle exec rake db:migrate
    $ bundle exec rails s

License
-------------------------------
[The MIT License (MIT)](http://opensource.org/licenses/mit-license)
Copyright (c) 2014 codefirst
