# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|

  # General Gem Information
  s.name        = 'mercury-rails'
  s.date        = '2011-11-15'
  s.version     = '0.4.8'
  s.authors     = ['Jeremy Jackson', 'DSC']
  s.email       = ['jejacks0n@gmail.com', 'tech@dsc.net']
  s.homepage    = 'http://github.com/dadamsuk/mercury'
  s.summary     = %Q{A fully featured and advanced HTML5 WYSIWYG editor written in CoffeeScript on top of Rails 3.1}
  s.description = %Q{A fully featured and advanced HTML5 WYSIWYG editor written in CoffeeScript on top of the Rails 3.1 asset stack}
  s.licenses    = ['MIT']


  # Runtime Dependencies
  s.add_runtime_dependency('rails', [">= 3.1.0"])
  s.add_runtime_dependency('paperclip')
  s.add_runtime_dependency('coffee-script')
  s.add_runtime_dependency('best_in_place')

  # Development Dependencies
  s.add_development_dependency('rocco')
  s.add_development_dependency('uglifier')
  s.add_development_dependency('jquery-rails')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('ruby-debug19')
  s.add_development_dependency('evergreen')
  s.add_development_dependency('selenium-webdriver')
  s.add_development_dependency('cucumber-rails')
  s.add_development_dependency('fuubar-cucumber')
  s.add_development_dependency('capybara')
  s.add_development_dependency('capybara-firebug')
  s.add_development_dependency('database_cleaner')


  # Gem Files
  s.extra_rdoc_files  = ["LICENSE"]
  s.files             = Dir['lib/**/*', 'vendor/assets/**/*', 'app/**/*', 'db/migrate/*', 'config/engine.rb']
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

end
