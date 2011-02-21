# encoding: utf-8

Gem::Specification.new do |s|
  s.name = %q{pispasep_rb}
  s.version = '0.0.1'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Rodrigo Manhães']
  s.date = %{2011-02-09}
  s.description = %{}
  s.email = ['rmanhaes@gmail.com']
  s.files = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.autorequire = 'pispasep_rb'
  s.rubyforge_project = %q{pispasep_rb}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Easy searching for ActiveRecord applications}
  s.add_dependency 'activerecord', '~>3.0.0'
  s.homepage = 'http://github.com/rodrigomanhaes/pispasep_rb'
end

