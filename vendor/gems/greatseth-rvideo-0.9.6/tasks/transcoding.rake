def transcode_single_job(recipe, input_file)
  puts "Transcoding #{File.basename(input_file)} to #{recipe}"
  r = YAML.load_file(File.dirname(__FILE__) + '/test/recipes.yml')[recipe]
  transcoder = RVideo::Transcoder.new(input_file)
  output_file = "#{TEMP_PATH}/#{File.basename(input_file, ".*")}-#{recipe}.#{r['extension']}"
  FileUtils.mkdir_p(File.dirname(output_file))
  begin
    transcoder.execute(r['command'], {:output_file => output_file}.merge(r))
    puts "Finished #{File.basename(output_file)} in #{transcoder.total_time}"
  rescue StandardError => e
    puts "Error transcoding #{File.basename(output_file)} - #{e.class} (#{e.message}\n#{e.backtrace})"
  end
end

def set_logger(path_or_io)
  RVideo::Transcoder.logger = Logger.new(path_or_io)
end

###

desc "Process a file"
task :transcode do
  set_logger STDOUT
  transcode_single_job ENV['RECIPE'], ENV['FILE']
end

desc "Batch transcode files"
task "transcode:batch" do
  set_logger File.dirname(__FILE__) + '/test/output.log'
  
  f = YAML.load_file(File.dirname(__FILE__) + '/test/batch_transcode.yml')
  
  recipes = f['recipes']
  files   = f['files']
  
  files.each do |f|
    file = "#{File.dirname(__FILE__)}/test/files/#{f}"
    recipes.each { |r| transcode_single_job r, file }
  end
end
