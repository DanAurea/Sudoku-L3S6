require 'bundler/gem_tasks'
task :default => [:test]

task :test do 
	ruby "test/unitTest.rb"
end

task :install do
	puts "Installation de Dogeku en cours..."
	puts
	
	# Delete gem already built previously
	fileExist = !Dir.glob('./Dogeku*.gem').empty?
	if (fileExist)
		sh "rm Dogeku*.gem"
	end

	# Build and install a newer gem
	sh "gem build Dogeku.gemspec"
	gemName =  `ls | grep Dogeku*.gem`
	sh "gem install #{gemName}"
end