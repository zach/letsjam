spec = Gem::Specification.new do |s|
  s.name = 'letsjam'
  s.version = '0.2'
  s.summary = 'Code Competition Utility for Ruby'
  s.description = 'Code Competition Utility for Ruby'
  s.author = ['Endel Dreyer', 'Zach Baker']
  s.email = ['endel.dreyer@gmail.com', 'zach@zachbaker.com']
  s.homepage = "https://github.com/zach/googlecodejam"

  s.files = `git ls-files`.split("\n").select {|f| !f.index('.rb.swp') }
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = "lib"
  s.bindir = "bin"
end
