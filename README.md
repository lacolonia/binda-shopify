# binda-shopify
Extension that lets you import your Shopify products into your Binda application.

# Installation

Install Binda via terminal

Just add the gem to your application's Gemfile:

```ruby
gem 'binda-shopify', github: 'lacolonia/binda-shopify'
```

Then, run:

```bash
bundle install
```

After that, you need to setup your connection to Shopify and create Binda::Structures where your data will be imported.

```bash
bundle exec rails generate binda:shopify:install
```

Now you are good to go!
