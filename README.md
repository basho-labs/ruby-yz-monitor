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

The command-line `yz-monitor-errors` application is the original interface:

```
Usage: bin/yz-errors-sensu (options)
    -c, --crit CRIT                  The number of errors that trigger a critical warning.
    -h, --host HOST                  The Riak host to connect to.
    -i, --index INDEX                The index to query
    -p, --port PORT                  The Protocol Buffers port on the Riak host to query.
    -q, --query QUERY                The query to perform
    -w, --warn WARN                  The number of errors that trigger a warning.
```

The command-line tool has several error/unknown conditions, evaluated in this
order:

1. If the warning threshold is greater than the critical threshold, the check
will fail before attempting to connect to Riak.
2. If the Riak server cannot is not ping-able (due to a failed connection or
other misconfiguration), the check will fail.
3. If the Riak server does not have the specified index ('yz_err' is the
default), the check will fail.

```sh
yz-monitor-errors -w 1 -c 100 -i yz_err 127.0.0.1 17017
```

For different checks, write a small Ruby script:

```ruby
require 'yz-monitor'

c = Riak::Client.new pb_port: 17017
i = Riak::Search::Index.new c, 'yz_err'
q = Riak::Search::Query.new c, i, '*:*'
q.rows = 0 # we care about the total results found, not the actual results
case q.results.num_found
when (0..10) ...
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/./fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
