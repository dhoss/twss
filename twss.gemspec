Gem::Specification.new do |s|
  s.name = "twss"
  s.version = "0.0.4"
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Ben VandenBos"]
  s.email = "bvandenbos@gmail.com"
  s.homepage = "http://github.com/bvandenbos/twss"
  s.summary = "Pre-trained That's What She Said classifier"
  s.description = %q{Pre-trained "That's What She Said" Bayes classifier.
      Given a string, returns true if it's a TWSS joke.  Pre-trained from
      Twitter #twss.  Let the twss mashups begin!}

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.add_runtime_dependency("classifier", ["1.3.1"])
  
end
