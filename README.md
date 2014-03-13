[![Build Status](https://secure.travis-ci.org/denniskuczynski/beanstalkd_view.png?branch=master)](http://travis-ci.org/denniskuczynski/beanstalkd_view)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/denniskuczynski/beanstalkd_view)

Iso View
===============
A Sinatra app to view/manage beanstalkd queues that can be embedded in a Rails app similar to what's available in Resque.

Configuration
-------------

To use in a Rails app, include the gem in your Gemfile:

``` ruby
gem iso_view
```


Embedding in a Rails app
------------------------

routes.rb

``` ruby
mount IsoView::Server, :at => "/iso"
```

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

