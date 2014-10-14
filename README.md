# So FAR so Good

A Ruby Gem to parse and manipulate the Federal Acquisition Regulation

[![Gem Version](https://badge.fury.io/rb/so_far_so_good.svg)](http://badge.fury.io/rb/so_far_so_good) [![Build Status](https://travis-ci.org/benbalter/so_far_so_good.svg)](https://travis-ci.org/benbalter/so_far_so_good)

## What it does

Right now, it simply gives you a hash of FAR 52.2x clauses and their description, but soon, much, much more!

## Usage

### Basic usage

```ruby
# Get all clauses
clauses = SoFarSoGood.clauses
=> [#<SoFarSoGood::Clause @number="52.200" @subject="Scope of subpart." @reserved="false",
 #<SoFarSoGood::Clause @number="52.202-1" @subject="Definitions." @reserved="false",
 #<SoFarSoGood::Clause @number="52.203-1" @subject="[Reserved]" @reserved="true",
 #<SoFarSoGood::Clause @number="52.203-2" @subject="Certificate of Independent Price Determination." @reserved="false",
 #<SoFarSoGood::Clause @number="52.203-3" @subject="Gratuities." @reserved="false", ... ]

# Get a list of clause numbers
SoFarSoGood::Clauses.numbers
=> ["52.200", "52.202-1", "52.203-1", "52.203-2", "52.203-3", "52.203-4", "52.203-5", ... ]

# Get a list of clause numbers, excluding reserved clauses
SoFarSoGood::Clauses.numbers(true)
=> ["52.200", "52.202-1", "52.203-1", "52.203-2", "52.203-3", "52.203-4", "52.203-5", ... ]

# Get a list of clause subjects
SoFarSoGood::Clauses.subjects
=> ["Scope of subpart.", "Definitions.", "[Reserved]", "Certificate of Independent Price Determination.", ... ]
```

### Working with individual clauses

```ruby
# Get a specific clause
clause = SoFarSoGood::Clauses["52.202-1"]
=> #<SoFarSoGood::Clause @number="52.202-1" @subject="Definitions." @reserved="false"

clause.number
=> "52.202-1"

clause.subject
=> "Definitions"

clause.reserved?
=> false

clause.citation
=> "[69 FR 34228, June 18, 2004]"

# The full clause body
clause.body
=> "As prescribed in 2.201, insert the following clause:..."

# The actual clause text to be inserted in the contract
clause.extract
=> "Definitions (JUL 2004)(a) When a solicitation provision or contract clause uses a word..."
```

### Using clause data elsewhere

```ruby

SoFarSoGood::Clauses.list.to_json
=> "[{\"number\":\"52.200\",\"subject\":\"Scope of subpart.\",\"reserverd\":false,\"citation\":..."

puts SoFarSoGood::Clauses.to_md
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Clause    | Description                                                                                                                                                   |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 52.200    | Scope of subpart.                                                                                                                                             |
| 52.202-1  | Definitions.                                                                                                                                                  |
| 52.203-2  | Certificate of Independent Price Determination.                                                                                                               |
| 52.203-3  | Gratuities.                                                                                                                                                   |
| 52.203-5  | Covenant Against Contingent Fees.                                                                                                                             |
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
