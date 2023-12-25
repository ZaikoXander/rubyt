# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'rubyt'
  s.version     = '0.0.1'
  s.required_ruby_version = '>= 3.2.2'
  s.summary     = 'A ruby type checking gem'
  s.description = 'Rubyt is a ruby gem that provides type checking functionality. It includes support for various types such as Boolean, Integer, String, Array, Hash and more. This gem is designed to enforce type safety, facilitating the creation of readable and maintainable code. It includes custom error handling for type mismatches. With its ease of use and integration, it can seamlessly fit into existing projects.'
  s.authors     = ['ZaikoXander']
  s.files       = Dir['lib/**/*']
  s.homepage    = 'https://github.com/ZaikoXander/rubyt'
  s.license     = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
end
