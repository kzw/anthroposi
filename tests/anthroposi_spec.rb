require 'anthroposi'

describe 'significant digits' do
  data = { [0, 0] => 0, [2, 1] => 2, [3.14159, 2] => 3.1, [1234, 1] => 1000,
           [116_067, 2] => 120_000, [7.5542144e-3, 2] => 0.0076, [-83.980e4, 1] => -800_000,
           [888, 0] => 0, [888, 1] => 900, [498_989, 1] => 500_000,
           [-4.4689898088e7, 1] => -40_000_000, [489_189, 0] => 0, [0, 3] => 0 }
  data.each do |input, answer|
    it "gives #{answer} if rounding #{input[0]} into #{input[1]} significant digits" do
      expect(significant_digits(*input)).to eq answer
    end
  end
end

describe 'human units' do
  data = { 0 => %w(0B 0), 2 => %w(2.0B 2.0), 1_234 => %w(1.21KiB 1.23K),
           1024**7 => %w(1.0ZiB 1.18Z),
           1000**7 => %w(867EiB 1.0Z),
           5_960_000 => %w(5.68MiB 5.96M),
           7_000_000_000 => %w(6.52GiB 7.0G),
           756_200_000_000 => %w(704GiB 756G),
           7_000_000_000_000 => %w(6.37TiB 7.0T),
           9_111_000_000_000_000                  => %w(8.09PiB 9.11P),
           19_999_111_000_000_000_000             => %w(17.3EiB 20.0E),
           2_245_999_111_000_000_000_000          => %w(1.9ZiB 2.25Z),
           42_342_239_999_111_000_000_000_000     => %w(35.0YiB 42.3Y),
           67_111_567_239_779_111_990_060_009_003 => %w(5.55e+04YiB 6.71e+04Y) }

  data.each do |raw, human|
    it "turns #{raw} bytes into #{human[0]} binary unit" do
      expect(human_size(raw)).to eq human[0]
    end
  end

  data.each do |raw, human|
    it "turns #{raw} into #{human[1]} with SI prefix" do
      expect(human_decimal_size(raw)).to eq human[1]
    end
  end

  it 'does not handle string' do
    expect { human_size('2') }.to raise_error ArgumentError
  end

  it 'does not handle fractional number' do
    expect { human_size(0.5) }.to raise_error ArgumentError
  end
end
