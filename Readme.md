Pagelime Rails Plugin
=====================

Easily add the Pagelime CMS to your rails app.

Pagelime is a simple CMS service that allows you to define editable regions in your content without installing any software on your site or app. Simply add a class="cms-editable" to any HTML element, and log-in to the Pagelime CMS service to edit your content and images with a nice UI. We host all of the code, content, and data until you publish a page. When you publish a page, we push the content to your site/app via secure FTP or web APIs.

One line example:
`<div id="my_content" class="cms-editable">This content is now editable in Pagelime... no code... no databases... no fuss</div>`

Getting Started
---------------

Requirements:

* Pagelime account (either a standalone from pagelime.com or as a Heroku add-on)
* Nokogiri gem

### Step 1. (Skip if using Heroku add-on)
If NOT on Heroku, set up a site for your Rails app in Pagelime. Make sure that the "Integration Method" for your site on the advanced tab is set to "web services"

### Step 2.
Require the **pagelime_rails** gem

#### For Rails 2
edit your `config/environment.rb` file and add:

`config.gem "pagelime_rails"`

then run

`rake gems:install`

#### For Rails 3
edit your `Gemfile` and add

`gem "pagelime_rails"`

then run

`bundle install`

### Step 3. (Only for Rails 2.3.X)
Add the plugin routes to your `config/routes.rb` configuration:

`map.cms_routes`

These routes are used by Pagelime to clear any caches after save and publish events on your files.

*Rails 3 does not need this statement, as the plugin will behave as an engine*

### Step 4.
For any controller that renders views that you want editable, add the acts_as_cms_editable behavior like so:

    class CmsPagesController < ApplicationController
        # attach the cms behavior to the controller
        acts_as_cms_editable

        def index
        end
    end

You can pass an `:except` parameter just like with a filter like so:

`acts_as_cms_editable :except => :index`

### Step 5.
Create some editable regions in your views like so:

`<div id="my_content" class="cms-editable">this is now editable</div>`

*The ID and the class are required for the CMS to work*

### Step 6. (OPTIONAL)
If you don't want to have your entire controller CMS editable for some reason, you can sorround areas in your view with a code block like so:

<% cms_content do %>
	<div id="my_content" class="cms-editable">hello world</div>
<% end %>

Copyright (c) 2011 Pagelime LLC, released under the MIT license