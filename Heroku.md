Pagelime CMS Addon
=====================

The CMS add-on enables the Pagelime CMS for your app, and allows your team to edit content on your Heroku app without commiting new code, modifying the database, or impacting the release process.

Pagelime is a simple CMS service that allows you to define editable regions in your content without installing any software on your site or app. Simply add a `class="cms-editable"` to any HTML element, and log-in to the Pagelime CMS service to edit your content and images with a nice UI. We host all of the code, content, and data until you publish a page. When you publish a page, we push the content to your site/app via secure FTP or web APIs.

In your views, make any element editable just by adding a CSS class:
`<div id="my_content" class="cms-editable">This content is now editable in Pagelime... no code... no databases... no fuss</div>`

Getting Started
---------------

### Step 1.
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

### Step 2. (Only for Rails 2.3.X)
Add the plugin routes to your `config/routes.rb` configuration:

`map.cms_routes`

These routes are used by Pagelime to clear any caches after save and publish events on your files.

*Rails 3 does not need this statement, as the plugin will behave as an engine*

### Step 3.
For any controller that renders views that you want editable, add the acts_as_cms_editable behavior like so:

    class CmsPagesController < ApplicationController
        # attach the cms behavior to the controller
        acts_as_cms_editable

        def index
        end
    end

You can pass an `:except` parameter just like with a filter like so:

`acts_as_cms_editable :except => :index`

### Step 4.
Create some editable regions in your views like so:

`<div id="my_content" class="cms-editable">this is now editable</div>`

*The ID and the class are required for the CMS to work*

### Step 5. (OPTIONAL)
If you don't want to have your entire controller CMS editable for some reason, you can sorround areas in your view with a code block like so:

	<% cms_content do %>
		<div id="my_content" class="cms-editable">hello world</div>
	<% end %>
	
### Step 6.
Add the pagelime addon to your app from the command line:

`heroku addons:add pagelime`

How it works under the hood
---------------------------
Pagelime is a cloud CMS. It provides a simple WYSIWYG editing interface for your pages, and pushes updated content and images to your app.
