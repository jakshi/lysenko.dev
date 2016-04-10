require 'colorize'

github_destination = 'origin'

task default: %w[deploy]

task :deploy do
  puts "Deploying updates to GitHub...".green
  sh 'hugo'
  sh "git subtree push --prefix=public #{github_destination} gh-pages"
  puts "Deploy is finished".green
end
