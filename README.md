# Lolcommits Uploldz

[![Gem](https://img.shields.io/gem/v/lolcommits-uploldz.svg?style=flat)](http://rubygems.org/gems/lolcommits-uploldz)
[![Travis](https://img.shields.io/travis/com/lolcommits/lolcommits-uploldz/master.svg?style=flat)](https://travis-ci.com/lolcommits/lolcommits-uploldz)
[![Depfu](https://img.shields.io/depfu/lolcommits/lolcommits-uploldz.svg?style=flat)](https://depfu.com/github/lolcommits/lolcommits-uploldz)
[![Maintainability](https://api.codeclimate.com/v1/badges/adb505198ff0e8e8e170/maintainability)](https://codeclimate.com/github/lolcommits/lolcommits-uploldz/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/adb505198ff0e8e8e170/test_coverage)](https://codeclimate.com/github/lolcommits/lolcommits-uploldz/test_coverage)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your
webcam every time you git commit code, and archives a lolcat style image
with it. Git blame has never been so much fun!

This plugin uploads each lolcommit to a remote server after capturing.
You configure the plugin by setting a remote endpoint to handle the HTTP
post request. The following params will be sent:

* `file` - captured lolcommit file
* `message` - the commit message
* `repo` - repository name e.g. lolcommits/lolcommits
* `sha` - commit SHA
* `author_name` - the commit author name
* `author_email` - the commit author email address
* `key` - optional key (string) from plugin config

You can also set an optional HTTP Basic Auth header (username and/or
password).

## Requirements

* Ruby >= 2.4
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

After installing the lolcommits gem, install this plugin with:

    $ gem install lolcommits-uploldz

Then configure to enable and set the remote endpoint:

    $ lolcommits --config -p uploldz
    # set enabled to `true`
    # set the remote endpoint (must begin with http(s)://)
    # optionally set a key (sent in params) and/or HTTP Basic Auth credentials

That's it! Provided the endpoint responds correctly, your next lolcommit
will be uploaded to it. To disable use:

    $ lolcommits --config -p uploldz
    # and set enabled to `false`

## Development

Check out this repo and run `bin/setup`, this will install all
dependencies and generate docs. Use `bundle exec rake` to run all tests
and generate a coverage report.

You can also run `bin/console` for an interactive prompt that will allow
you to experiment with the gem code.

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-uploldz/issues). Take a
moment to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-uploldz/issues)
and [pull
requests](https://github.com/lolcommits/lolcommits-uploldz/pulls) are
welcome on GitHub.

When submitting pull requests, remember to add tests covering any new
behaviour, and ensure all tests are passing on [Travis
CI](https://travis-ci.com/lolcommits/lolcommits-uploldz). Read the
[contributing
guidelines](https://github.com/lolcommits/lolcommits-uploldz/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for
collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.
See
[here](https://github.com/lolcommits/lolcommits-uploldz/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.com/lolcommits/lolcommits-uploldz)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-uploldz)
* [Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-uploldz/coverage)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-uploldz)
* [Issues](http://github.com/lolcommits/lolcommits-uploldz/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-uploldz/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-uploldz)
* [GitHub](https://github.com/lolcommits/lolcommits-uploldz)
