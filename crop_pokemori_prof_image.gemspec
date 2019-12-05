
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crop_pokemori_prof_image/version'

Gem::Specification.new do |spec|
  spec.name          = 'crop_pokemori_prof_image'
  spec.version       = CropPokemoriProfImage::VERSION
  spec.authors       = ['Osamu Takiya']
  spec.email         = ['takiya@toran.sakura.ne.jp']

  spec.summary       = %q{crop the prof image of 'Doubutsu-No-Mori Pocket Camp' (Animal Crossing Pocket Camp)}
  spec.description   = %q{crop the captured profile image of 'Doubutsu-No-Mori Pocket Camp' and divide it to 'face', 'name' and 'id' images}
  spec.homepage      = 'https://github.com/corselia/crop-pokemori-prof-image'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'rmagick', '>= 4.1.0.rc2'
end
