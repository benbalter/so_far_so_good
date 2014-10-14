# So FAR so Good

A Ruby Gem to parse and manipulate the Federal Acquisition Regulation

[![Gem Version](https://badge.fury.io/rb/so_far_so_good.svg)](http://badge.fury.io/rb/so_far_so_good) [![Build Status](https://travis-ci.org/benbalter/so_far_so_good.svg)](https://travis-ci.org/benbalter/so_far_so_good)

## What it does

So FAR so Good is a Ruby Gem to interact with the Federal Acquisition Regulation. Right now, it only supports section 52.20x, the FAR standard contracting clause templates.

For any contract clause, it will provide:

* The section number
* The subject
* Whether it's a reserved section
* The formal citation
* The body (full clause text)
* The extract (what's inserted into the contract)

It will give you access to this information in object-oriented Ruby, as JSON, or as a markdown table for use elsewhere.

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
SoFarSoGood::Clauses.numbers(:exclude_reserved => true)
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

#### As JSON

```ruby

SoFarSoGood::Clauses.list.to_json
=> "[{\"number\":\"52.200\",\"subject\":\"Scope of subpart.\",\"reserverd\":false,\"citation\":..."
```

#### As a markdown table

```ruby
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

#### Individual clauses as markdown

```ruby

# The body
puts SoFarSoGood::Clauses["52.202-1"].body(:format => :markdown)
=> As prescribed in 2.201, insert the following clause:

# The extract
puts SoFarSoGood::Clauses["52.202-1"].extract(:format => :markdown)
=> ### Definitions (JUL 2004)

(a) When a solicitation provision or contract clause uses a word or term that is defined in the Federal Acquisition Regulation (FAR), the word or term has the same meaning as the definition in FAR 2.101 in effect at the time the solicitation was issued, unless— ...
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
