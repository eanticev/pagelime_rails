Pagelime Rails Plugin
=====================

Easily add the Pagelime CMS to your Rails app.

Pagelime is a simple CMS service that allows you to define editable regions in your pages without installing any software on your website or app. 
Simply add a `class="cms-editable"` to any HTML element, and log-in to the Pagelime CMS service to edit your content and images with a nice, simple UI. 
We host all of the code, content, and data until you publish a page. 
When you publish a page, the PageLime CMS pushes the content to your website via secure FTP or an API. 
Using the Rails plugin, we pull the new content into your app dynamically via an API.

### Quick Start (2 lines of code!)

First, add the `cms-editable` class and an `id` to make content editable:

```html
<div id="my_content" class="cms-editable">
  This content is now editable in Pagelime... no code... no databases... no fuss
</div>
```

Second, add `acts_as_cms_editable` to your controller to display the latest content:

```ruby
class CmsPagesController < ApplicationController
  acts_as_cms_editable
end
```

Done!

Getting Started
---------------

### Requirements

* Pagelime account (either standalone [pagelime.com](http://pagelime.com) or via the [Pagelime Heroku add-on](https://addons.heroku.com/pagelime))
* [Pagelime Rack gem](https://github.com/eanticev/pagelime_rack) (`pagelime-rack`)

### Step 1: Install the Pagelime Rails gem

#### For Rails 3

Edit your `Gemfile` and add

```ruby
gem "pagelime-rack"
gem "pagelime-rails"
```

then run

```bash
bundle install
```

#### For Rails 2 (not officially supported)

Edit your `config/environment.rb` file and add:

```ruby
config.gem "pagelime-rack"
config.gem "pagelime-rails"
```

then run

```bash
rake gems:install
```

### Step 2: Setup your Pagelime credentials

*(Skip if using Heroku add-on)*

If you are NOT using the [Pagelime Heroku add-on](https://addons.heroku.com/pagelime), set up an account at [pagelime.com](http://pagelime.com). 
Make sure that the "Integration Method" for your site on the advanced tab is set to "web services".

### Step 3: Configure your application

For any controller that renders views that you want editable, add the `acts_as_cms_editable` behavior like so:

```ruby
class CmsPagesController < ApplicationController
  # attach the cms behavior to the controller
  acts_as_cms_editable

  def index
  end
end
```

You can pass an `:except` parameter just like with a filter like so:

```ruby
acts_as_cms_editable :except => :index
```

Caching and logging are automatically setup using your Rails configuration. 
You can specify custom caching and logging by adding the following to an initializer file.

```ruby
Pagelime.configure do |config|

  # object that responds to `fetch` and `delete`
  config.cache = Rails.cache
  
  # options passed to `fetch(key, options = {}, &block)`
  config.cache_fetch_options = { :expires_in => 1.year }
  
  # any standard logger
  config.logger = Rails.logger
  
end
```

*It is highly recommended that you enable server caching to reduce latency on each request when retrieving CMS content. [MemCachier](https://www.memcachier.com/) has a great [Heroku addon](https://addons.heroku.com/memcachier) for caching if you don't have caching configured.*

#### Rack Middleware

The `Rack::Pagelime` middleware is inserted before `Rack::ConditionalGet` to retrieve CMS content before HTTP caching is performed.

#### Additional configuration options

*Read the [`pagelime-rack`](https://github.com/eanticev/pagelime_rack) documentation for more configuration options.*

### Step 4: Make pages editable

Create some editable regions in your views like so:

```html
<div id="my_content" class="cms-editable">
  this is now editable
</div>
```

*The `ID` and the `class` are required for the CMS to work*

Optionally: If you don't want to have your entire controller CMS editable for some reason, you can sorround areas in your view with a code block like so:

```rhtml
<% cms_content do %>
  <div id="my_content" class="cms-editable">
    hello world
  </div>
<% end %>
```

### Step 5: Edit your pages!

#### For Heroku users

If you're using the Pagelime Heroku add-on, go to the Heroku admin for your app and under the "Resources" tab you will see the Pagelime add-on listed. 
Click on the add-on name and you will be redirected to the Pagelime CMS editor. 
From there you can edit any page in your Rails app!

#### For Pagelime.com users

If you have a standalone Pagelime account, simply go to [pagelime.com](http://pagelime.com) and edit your site as usual (see Step 2). 



Copyright (c) 2013 Pagelime LLC, released under the MIT license
