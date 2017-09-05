### Anthroposi

Ruby module to turn a number into a string appended with binary units such as MiB, GiB
as explained in (https://en.wikipedia.org/wiki/Binary_prefix)
and to turn number into string appended with si prefixes.
## Install

Gem
```
gem install anthroposi
```

Git
```
git clone https://github.com/kzw/anthroposi
cd anthroposi
make
```
## Usage

```ruby
require 'anthroposi'

puts human_size(2900)
  
```
This outputs `2.83KiB`

## Tests
The behavior of this module is documented in the tests.  `make test` will trigger a run
```
KZs-MacBook-Pro:anthroposi me$ make test
rspec -I lib tests && touch test

significant digits
  gives 0 if rounding 0 into 0 significant digits
  gives 2 if rounding 2 into 1 significant digits
  gives 3.1 if rounding 3.14159 into 2 significant digits
  gives 1000 if rounding 1234 into 1 significant digits
  gives 120000 if rounding 116067 into 2 significant digits
  gives 0.0076 if rounding 0.0075542144 into 2 significant digits
  gives -800000 if rounding -839800.0 into 1 significant digits
  gives 0 if rounding 888 into 0 significant digits
  gives 900 if rounding 888 into 1 significant digits
  gives 500000 if rounding 498989 into 1 significant digits
  gives -40000000 if rounding -44689898.088 into 1 significant digits
  gives 0 if rounding 489189 into 0 significant digits
  gives 0 if rounding 0 into 3 significant digits

human units
  turns 0 bytes into 0B binary unit
  turns 2 bytes into 2.0B binary unit
  turns 1234 bytes into 1.21KiB binary unit
  turns 1180591620717411303424 bytes into 1.0ZiB binary unit
  turns 1000000000000000000000 bytes into 867EiB binary unit
  turns 5960000 bytes into 5.68MiB binary unit
  turns 7000000000 bytes into 6.52GiB binary unit
  turns 756200000000 bytes into 704GiB binary unit
  turns 7000000000000 bytes into 6.37TiB binary unit
  turns 9111000000000000 bytes into 8.09PiB binary unit
  turns 19999111000000000000 bytes into 17.3EiB binary unit
  turns 2245999111000000000000 bytes into 1.9ZiB binary unit
  turns 42342239999111000000000000 bytes into 35.0YiB binary unit
  turns 67111567239779111990060009003 bytes into 5.55e+04YiB binary unit
  turns 0 into 0 with SI prefix
  turns 2 into 2.0 with SI prefix
  turns 1234 into 1.23K with SI prefix
  turns 1180591620717411303424 into 1.18Z with SI prefix
  turns 1000000000000000000000 into 1.0Z with SI prefix
  turns 5960000 into 5.96M with SI prefix
  turns 7000000000 into 7.0G with SI prefix
  turns 756200000000 into 756G with SI prefix
  turns 7000000000000 into 7.0T with SI prefix
  turns 9111000000000000 into 9.11P with SI prefix
  turns 19999111000000000000 into 20.0E with SI prefix
  turns 2245999111000000000000 into 2.25Z with SI prefix
  turns 42342239999111000000000000 into 42.3Y with SI prefix
  turns 67111567239779111990060009003 into 6.71e+04Y with SI prefix
  does not handle string
  does not handle fractional number

Finished in 0.01261 seconds (files took 0.10129 seconds to load)
43 examples, 0 failures
```

## Prior art

Research into existing works point to similar api available in [rail](https://github.com/rails/rails)
, possibly also in [active state](https://www.activestate.com/ruby-programming), and in other
[gems](https://rubygems.org/search?utf8=%E2%9C%93&query=human-bytes)
