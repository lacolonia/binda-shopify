# Binda Shopify
Extension that lets you import your Shopify products into your Binda application.

**Binda** is a headless CMS with an intuitive out-of-the-box interface which makes very easy creating application infrastructures. For more info about Binda structure please visit the [official documentation](http://www.rubydoc.info/gems/binda)

[![Maintainability](https://api.codeclimate.com/v1/badges/00f7b3a4bb33ea7637c2/maintainability)](https://codeclimate.com/github/lacolonia/binda-shopify/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/00f7b3a4bb33ea7637c2/test_coverage)](https://codeclimate.com/github/lacolonia/binda-shopify/test_coverage)


## Requirements

Before you install **Binda Shopify** you need to setup your Shopify account properly. Please follow the steps below.

### Create a private app

Binda Shopify relies on private apps. A detailed guide on what are and how to create them can be found in the [Shopify official documentation](https://help.shopify.com/manual/apps/private-apps).

## Installation

If you haven't read the **Requirements** section do it now before continuing.
Install Binda via terminal. See [Binda installation guide](https://www.rubydoc.info/gems/binda#Installation) for more information.

Just add the gem to your application's Gemfile:

```ruby
gem 'binda-shopify', github: 'lacolonia/binda-shopify'
```

Then, run:

```bash
bundle install
```

After that, you need to setup your connection to Shopify and create `Binda::Structures` where your data will be imported. To do so you can run the following command.

(development mode)

```bash
rails generate binda:shopify:install
```

(production mode)

```bash
RAILS_ENV=production bundle exec rails generate binda:shopify:install
```

Once you complete the installation process you are good to go! Log into your admin panel and click the sync button.
