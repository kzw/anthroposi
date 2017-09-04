### Anthroposi

Ruby module to turn a number into a string appended with binary units such as MiB, GiB
as explained in (https://en.wikipedia.org/wiki/Binary_prefix)
and to turn number into string appended with si prefixes.

##Usage

```ruby
require 'anthroposi'

puts human_size(2900)
  
```
This outputs `2.83KiB`
##Prior work
Research into existing work point to similar api available in [rail](https://github.com/rail/rail)
and possibly also in [active state](https://www.activestate.com/ruby-programming)
