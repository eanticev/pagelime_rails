Pagelime Rails Plugin
=====================

Easily add the Pagelime CMS to your Rails app.

Pagelime is a simple CMS service that allows you to define editable regions in your content without installing any software on your site or app. 
Simply add a `class="cms-editable"` to any HTML element, and log-in to the Pagelime CMS service to edit your content and images with a nice UI. 
We host all of the code, content, and data until you publish a page. 
When you publish a page, we push the content to your site/app via secure FTP or web APIs.

One line example:

    <div id="my_content" class="cms-editable">
      This content is now editable in Pagelime... no code... no databases... no fuss
    </div>

Getting Started
---------------

### Requirements

* Pagelime account (either standalone [pagelime.com](http://pagelime.com) or via the [Pagelime Heroku add-on](https://addons.heroku.com/pagelime))
* [Pagelime Rack gem](https://github.com/eanticev/pagelime_rack) (`pagelime-rack`)

### Step 1: Install the Pagelime Rails gem

#### For Rails 2

Edit your `config/environment.rb` file and add:

    config.gem "pagelime-rails"

then run

    rake gems:install

#### For Rails 3

Edit your `Gemfile` and add

    gem "pagelime-rails"

then run

    bundle install

### Step 2: Setup your Pagelime credentials

*(Skip if using Heroku add-on)*

If you are NOT using the [Pagelime Heroku add-on](https://addons.heroku.com/pagelime), set up an account at [pagelime.com](http://pagelime.com). 
Make sure that the "Integration Method" for your site on the advanced tab is set to "web services".

### Step 3: Configure your application

For any controller that renders views that you want editable, add the `acts_as_cms_editable` behavior like so:

    class CmsPagesController < ApplicationController
      # attach the cms behavior to the controller
      acts_as_cms_editable
    
      def index
      end
    end

You can pass an `:except` parameter just like with a filter like so:

    acts_as_cms_editable :except => :index

#### Only for Rails 2.3.x

Add the plugin routes to your `config/routes.rb` configuration:

    map.cms_routes

These routes are used by Pagelime to clear any caches after save and publish events on your files.

*Rails 3 does not need this statement, as the plugin will behave as an engine*

#### Additional configuration options

*Read the [`pagelime-rack`](https://github.com/eanticev/pagelime_rack) documentation for more configuration options.*

### Step 4: Make pages editable

Create some editable regions in your views like so:

    <div id="my_content" class="cms-editable">
      this is now editable
    </div>

*The ID and the class are required for the CMS to work*

Optionally: If you don't want to have your entire controller CMS editable for some reason, you can sorround areas in your view with a code block like so:

    <% cms_content do %>
      <div id="my_content" class="cms-editable">
        hello world
      </div>
    <% end %>

### Step 5: Edit your pages!

#### For Heroku users

If you're using the Pagelime Heroku add-on, go to the Heroku admin for your app and under the "Resources" tab you will see the Pagelime add-on listed. 
Click on the add-on name and you will be redirected to the Pagelime CMS editor. 
From there you can edit any page in your Rails app!

#### For Pagelime.com users

If you have a standalone Pagelime account, simply go to [pagelime.com](http://pagelime.com) and edit your site as usual (see Step 2). 



Copyright (c) 2013 Pagelime LLC, released under the MIT license
