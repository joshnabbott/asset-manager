desc "Release the website and new gem version"
task :deploy => [:manifest, :release, :publish_docs]

desc "Regenerates website, rdoc and package. Installs the gem locally."
task "deploy:local" => ["web:generate", :redocs, :repackage, :install]
