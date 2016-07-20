Iso View
===============
A Sinatra app to get ISO codes query that can be embedded in a Rails app.

#### What it is?

* countries       - 3166 (all lang avalable at gem countries)
* subdivisions    - 3166-2 (на русском)
* cities          - parse from api.vk.com

#### Why I need it?

* small embedded and standalone app
* use it with my cascade select2
* learn how to integrate sinatra in rails


Configuration
-------------

To use in a Rails app, include the gem in your Gemfile:

``` ruby
gem 'iso_view'
```


Embedding in a Rails app
------------------------

routes.rb

``` ruby
  mount IsoView::Server, :at => "/iso"
  get "/countries/:lang?" => IsoView::Server
  get "/subdivisions/:country/:lang?" => IsoView::Server
  get "/cities/:country/:subdivision/:lang?" => IsoView::Server
```

example

    http://127.0.0.1:3000/iso/countries/en
    http://127.0.0.1:3000/iso/subdivisions/ru/ru
    http://127.0.0.1:3000/iso/cities/RU/KHA/ru

`:lang?` - translation you prefer

run as standalone

    iso_view

or from a Rails app:

    bundle exec iso_view

(This will use the vegas gem to launch the Sinatra app on an available port.)

Alternatively, a Rackup file is provided.  To use: cd into the beanstalkd_view directory and execute:

rackup

License
------------------------

iso_view is released under the MIT license:

* http://www.opensource.org/licenses/MIT

It makes use of the following components also using the MIT license:

* Sinatra - http://www.sinatrarb.com/

