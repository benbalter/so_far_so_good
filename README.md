# So FAR so Good

A Ruby Gem to parse and manipulate the Federal Acquisition Regulation

## What it does

Right now, it simply gives you a hash of FAR 52.2x clauses and their description, but soon, much, much more!

## Usage

```ruby
SoFarSoGood.clauses
> {"52.200"=>"Scope of subpart.",
 "52.201"=>"[Reserved]",
 "52.202-1"=>"Definitions.",
 "52.203-1"=>"[Reserved]",...
 }
```

## Installation

Add this line to your application's Gemfile:

    gem 'so_far_so_good'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install so_far_so_good

## Contributing

1. Fork it ( https://github.com/benbalter/so_far_so_good/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
