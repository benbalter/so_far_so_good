# So FAR so Good

A Ruby Gem to parse and manipulate the Federal Acquisition Regulation (FAR) and Defense Federal Acquisition Regulation Supplement (DFARS)

[![Gem Version](https://badge.fury.io/rb/so_far_so_good.svg)](http://badge.fury.io/rb/so_far_so_good) [![Build Status](https://travis-ci.org/benbalter/so_far_so_good.svg)](https://travis-ci.org/benbalter/so_far_so_good)

## What it does

So FAR so Good is a Ruby Gem to interact with the Federal Acquisition Regulation (FAR) and Defense Federal Acquisition Regulation Supplement (DFARS). Right now, it supports section 52.20x and 252.20x, the FAR and DFARS standard contracting clause templates.

For any contract clause, it will provide:

* The section number
* The subject
* Whether it's a reserved section
* The formal citation
* The body (full clause text)
* The extract (what's inserted into the contract)
* A link to the full text online

It will give you access to this information in object-oriented Ruby, as JSON, or as a markdown table for use elsewhere.

## Usage

### Command line interface

`./bin/far [output] [NUMBER]`

The output option must be either "body" or "extract".

For example:
``` bash
$ far body 13.101
# 13.101. General.
```

### Basic usage

```ruby
subchapters = SoFarSoGood.subchapters
=> [#<SoFarSoGood::Subchapter year=2013 title=48 volume=2 chapter=1 name="FAR">,
    #<SoFarSoGood::Subchapter year=2013 title=48 volume=3 chapter=2 name="DFARS">]

# Get the FAR's subparts
subparts = SoFarSoGood.far.subparts
=> [#<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.200" subject="Scope of subpart." document="FAR" reserved=false>,
  #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.202-1" subject="Definitions." document="FAR" reserved=false>,
  #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.203-1" subject="[Reserved]" document="FAR" reserved=true>,
  #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.203-2" subject="Certificate of Independent Price Determination." document="FAR" reserved=false>,
  #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.203-3" subject="Gratuities." document="FAR" reserved=false>,
  #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.203-4" subject="[Reserved]" document="FAR" reserved=true>...]

# Get a list of subpart numbers
SoFarSoGood.far.numbers
=> ["52.200", "52.202-1", "52.203-1", "52.203-2", "52.203-3", "52.203-4", "52.203-5", ... ]

# Get a list of subpart numbers, excluding reserved clauses
SoFarSoGood.far.numbers(:reserved => false)
=> ["52.200", "52.202-1", "52.203-1", "52.203-2", "52.203-3", "52.203-4", "52.203-5", ... ]

# Get a list of subpart subjects
SoFarSoGood.far.subjects
=> ["Scope of subpart.", "Definitions.", "[Reserved]", "Certificate of Independent Price Determination.", ... ]
```

### Working with individual clauses

```ruby
# Get a specific subpart
subpart = SoFarSoGood["52.202-1"]
=> #<SoFarSoGood::Subpart year=2013 title=48 volume=2 chapter=1 number="52.202-1" subject="Definitions." document="FAR" reserved=false>

subpart.number
=> "52.202-1"

subpart.subject
=> "Definitions"

subpart.reserved?
=> false

subpart.citation
=> "[69 FR 34228, June 18, 2004]"

# The full clause body
subpart.body
=> "As prescribed in 2.201, insert the following clause:..."

# The actual clause text to be inserted in the contract
subpart.extract
=> "Definitions (JUL 2004)(a) When a solicitation provision or contract clause uses a word..."

subpart.link
=> "http://www.law.cornell.edu/cfr/text/48/52.202-1"
```

### Using subpart data elsewhere

#### As JSON

```ruby

SoFarSoGood.far.to_json
=> "[{\"number\":\"52.200\",\"subject\":\"Scope of subpart.\",\"reserverd\":false,\"citation\":..."
```

#### As a markdown table

```ruby
puts SoFarSoGood.far.to_md
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Clause    | Description                                                                                                                                                   |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 52.200    | Scope of subpart.                                                                                                                                             |
| 52.202-1  | Definitions.                                                                                                                                                  |
| 52.203-2  | Certificate of Independent Price Determination.                                                                                                               |
| 52.203-3  | Gratuities.                                                                                                                                                   |
| 52.203-5  | Covenant Against Contingent Fees.                                                                                                                             |
...

# Table without reserved subparts
puts SoFarSoGood.dfars.to_md(:reserved => false)

# Table with links to text
puts SoFarSoGood.far.to_md(:links => true)
...
| [52.222-34](http://www.law.cornell.edu/cfr/text/48/52.222-34) | Project Labor Agreement.                                                                                                                                      |
| [52.222-35](http://www.law.cornell.edu/cfr/text/48/52.222-35) | Equal Opportunity for Veterans.                                                                                                                               |
| [52.222-36](http://www.law.cornell.edu/cfr/text/48/52.222-36) | Affirmative Action for Workers With Disabilities.                                                                                                             |
| [52.222-37](http://www.law.cornell.edu/cfr/text/48/52.222-37) | Employment Reports on Veterans.                                                                                                                               |
| [52.222-38](http://www.law.cornell.edu/cfr/text/48/52.222-38) | Compliance with Veterans' Employment Reporting Requirements.                                                                                                  |
| [52.222-41](http://www.law.cornell.edu/cfr/text/48/52.222-41) | Service Contract Act of 1965.
...
```

#### As a CSV
```ruby
puts SoFarSoGood.far.to_csv(:reserved => false)
Clause,Description
52.200,Scope of subpart.
52.202-1,Definitions.
52.203-2,Certificate of Independent Price Determination.
52.203-3,Gratuities.
52.203-5,Covenant Against Contingent Fees.
```

#### Individual subparts as markdown

```ruby
# The body
puts SoFarSoGood["52.202-1"].body(:format => :markdown)
=> As prescribed in 2.201, insert the following clause:

# The extract
puts SoFarSoGood["52.202-1"].extract(:format => :markdown)
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
