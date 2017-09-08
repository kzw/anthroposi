# A class container for various constants and methods to convert numbers into string with SI prefixes
class Anthroposi
  SI_PREFIXES = %w(K M G T P E Z Y).freeze
  BINARY_UNITS = ['B'] + SI_PREFIXES.map { |p| "#{p}iB" }
  DECIMAL_PREFIXES = [''] + SI_PREFIXES
  KILO = 1024
  SIGNIFICANT_DIGITS = 3
  LARGEST_THRESHOLD = 9999

  # @param bytes [Number]
  # @param decimal[Boolean] optional
  # @raise ArgumentError if string or number less than 1 is passed in as bytes
  def initialize(bytes, decimal = false)
    raise(ArgumentError, 'no string or fractional number') if bytes > 0 && bytes < 1
    @bytes = bytes
    @bytes.zero? and return handle_zero(decimal)
    prepare(decimal)
    @unit = compute
  end

  # @return [String]
  # @example
  #   Anthroposi.new(314159).to_s #=> "314KiB"
  def to_s
    format @mantissa > LARGEST_THRESHOLD ? '%.2e%s' : '%s%s', @mantissa, @unit
  end

  private

  def prepare(decimal)
    if decimal
      @thousand = 1000
      @units = DECIMAL_PREFIXES
      @ordinal = Math.log10(@bytes).to_i / 3
    else
      @thousand = KILO
      @units = BINARY_UNITS
      @ordinal = Math.log2(@bytes).to_i / 10
    end
  end

  def handle_zero(decimal)
    @mantissa = 0
    @units = decimal ? DECIMAL_PREFIXES : BINARY_UNITS
    @unit = @units[0]
  end

  def compute
    if @ordinal < BINARY_UNITS.size
      @mantissa = significant_digits(@bytes.to_f / @thousand**@ordinal, SIGNIFICANT_DIGITS)
      return @units[@ordinal]
    end
    @mantissa = significant_digits(@bytes.to_f / @thousand**SI_PREFIXES.size, SIGNIFICANT_DIGITS)
    @units[-1]
  end
end

# helper method to compute a number to a given number of significant digits
# @param number [Numeric]
# @param digits [Integer] number of significant digits desired
# @return [Numeric]
# @example
#   significant_digits(116_067, 2) #=> 120000
def significant_digits(number, digits)
  return 0 if number.zero? || digits.zero?
  number.to_f.round(digits - 1 - Math.log10(number.abs).floor)
end

# wrapper function around Anthroposi class
# @param b [Integer] bytes
# @return [String] such as 3.14MiB, 234EiB
# @example
#   human_size(1024) #=> "1.0KiB"
def human_size(b)
  Anthroposi.new(b).to_s
end

# @param n [Numeric] number
# @return [String] such as 3.14M, 234E
# @example
#   human_decimal_size(1000) #=> "1.0M"
def human_decimal_size(n)
  Anthroposi.new(n, true).to_s
end
