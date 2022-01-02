require 'colorize'

github_destination = 'origin'
default_commit_message="rebuilding site #{Time.now}"

task default: %w[deploy]

task :deploy, :message do |t, args|
  commit_message = args[:message] || default_commit_message
  puts "Deploying updates to GitHub...".green
  sh 'hugo' # Build site
  sh 'git add -A' # Add all files to git stage
  sh "git commit -m '#{commit_message}' --allow-empty"
  sh "git push #{github_destination} master"
  sh "git subtree push --prefix=public #{github_destination} gh-pages" # Publish changes
  puts "Deploy is finished".green
end
