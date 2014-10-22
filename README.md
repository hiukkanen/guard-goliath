Guard::Goliath
===========

Want to restart your Rack development with *rackup* whilst you work? Now you can!

    guard 'goliath', port: 9000, app_file: 'app.rb' do
      watch('Gemfile.lock')
      watch(%r{*.rb})
    end

Options
-------

* `:port` is the port number to run on (default `9000`)
* `:environment` is the environment to use (default `development`)
* `:start_on_start` will start the server when starting Guard (default `true`)
* `:force_run` kills any process that's holding open the listen port before attempting to (re)start Rack (default `false`).
* `:daemon` runs the server as a daemon, without any output to the terminal that ran `guard` (default `false`).
* `:timeout` waits this number of seconds when restarting the Rack server before reporting there's a problem (default `20`).

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/dblock/guard-rack/raw/master/LICENSE.md) for details.

(c) 2014 [Nikolay Norkin](http://github.com/duderman)

