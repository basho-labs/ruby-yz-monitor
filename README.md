# Ruby Yokozuna Monitor

The Ruby Yokozuna Monitor gem keeps an eye on your Riak Search 2 (a.k.a.
"Yokozuna" or "yz") installation.

The intended use is to find objects that have failed indexing using the
`_yz_err` functionality, but it is customizable to monitor other yz
activity.

Using the [yokozuna error patch][1] distributed separately from Riak and this
gem, monitoring for erroneous records becomes vitally important, as they are
saved separately, and take up space over time.

[1]: https://github.com/basho-labs/yokozuna_error_patch

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yz-monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install .

## Usage

The command-line `yz-monitor-errors` application takes a hostname or IP address,
a port number, and an index name to look for `_yz_err` fields in:

```sh
yz-monitor-errors 127.0.0.1 17017 yz_err
```

For different checks, write a small Ruby script:

```ruby
require 'yz-monitor'

c = Riak::Client.new pb_port: 17017
i = Riak::Search::Index.new c, 'yz_err'
q = Riak::Search::Query.new c, i, '*:*'
m = Riak::Yokozuna::Monitor.new c, q
m.asdfasdfasdf
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/./fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
