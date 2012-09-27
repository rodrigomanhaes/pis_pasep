# encoding: utf-8

Gem::Specification.new do |s|
  s.name = %q{pis_pasep}
  s.version = '0.0.1'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Rodrigo Manhães']
  s.date = %{2011-02-09}
  s.description = %q{PIS/PASEP validations for pure Ruby and ActiveRecord apps}
  s.email = ['rmanhaes@gmail.com']
  s.files = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.autorequire = 'pis_pasep'
  s.rubyforge_project = %q{pis_pasep}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{PIS/PASEP validations for pure Ruby and ActiveRecord apps}
  s.add_dependency 'activerecord', '~>3.0'
  s.add_development_dependency 'rspec', '~>2.11.0'
  s.add_development_dependency 'sqlite3', '~>1.3.5'
  s.homepage = 'https://github.com/rodrigomanhaes/pis_pasep'
end
