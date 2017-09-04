Gem::Specification.new do |s|
  s.name        = 'anthroposi'
  s.version     = File.open('makefile', &:readline).chomp.split('=')[1]
  s.licenses    = ['MIT']
  s.summary     = 'Turn number in binary units such as MiB, KiB or decimal prefixes G, T'
  s.description = ''
  s.authors     = ['k z win']
  s.email       = 'rubygems@happyw.info'
  s.files       = Dir['lib/*']
  s.homepage    = 'https://github.com/kzw/anthroposi'
end
