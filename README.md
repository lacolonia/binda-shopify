# Binda Shopify
Extension that lets you import your Shopify products into your Binda application.

**Binda** is a headless CMS with an intuitive out-of-the-box interface which makes very easy creating application infrastructures. For more info about Binda structure please visit the [official documentation](http://www.rubydoc.info/gems/binda)

[![Maintainability](https://api.codeclimate.com/v1/badges/00f7b3a4bb33ea7637c2/maintainability)](https://codeclimate.com/github/lacolonia/binda-shopify/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/00f7b3a4bb33ea7637c2/test_coverage)](https://codeclimate.com/github/lacolonia/binda-shopify/test_coverage)

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

After that, you need to setup your connection to Shopify and create `Binda::Structures` where your data will be imported.

```bash
bundle exec rails generate binda:shopify:install
```

Now you are good to go!
