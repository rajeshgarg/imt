# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "imt"
  s.summary = "Insert TeamPage summary."
  s.description = "Insert TeamPage description."
  s.version = "0.0.1"
  s.files = Dir["{app,lib,config,public}/**/*"] + ["MIT-LICENSE",  "Gemfile", "README.rdoc"]  
  s.authors = ["Rajesh Garg"]
  s.email = ["ronit.garg@gmail.com"]
  s.add_dependency('rmagick')
  s.add_dependency('jquery-fileupload-rails')

  s.add_dependency('carrierwave')
  
end