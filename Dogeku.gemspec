Gem::Specification.new do |s|
  s.name        = 'Dogeku'
  s.version     = '1.0.0'
  s.date        = '2017-04-22'

  s.summary     = "Sudoku helper"
  s.description = "Help you to resolve a sudoku and learn how to resolve them."
  
  s.authors     = ["DanAurea","Nikuto","Flambii","gaduran","AlexTAB","yguenver","keryann", "BastienMor"]
  s.email       = 'laochi.bc@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/Dogeku'
  

  s.files       = Dir.glob("{bin,app,assets,doc,test}/**/*") + %w(LICENSE README.md)
  s.executables = ['dogeku']

  s.licenses = ['MIT', 'GPL-2.0']

  s.extra_rdoc_files = ['README.md']
  
  s.post_install_message = "\nMerci d'avoir installé Dogeku, vous ne regretterez rien !"
end