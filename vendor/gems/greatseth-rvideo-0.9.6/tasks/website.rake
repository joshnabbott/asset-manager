namespace :web do
  desc "Regnerate website files from text templates"
  task :generate do
    Dir['website/**/*.txt'].each do |txt|
      sh %{ ruby scripts/txt2html #{txt} > #{txt.gsub(/txt$/,'html')} }
    end
  end
end
