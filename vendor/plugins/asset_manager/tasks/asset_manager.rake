namespace :assets do
  
  desc "Encode videos"
  task :encode => :environment do
    for video in Video.find(:all)
      video.encode_video
    end
  end
  
end
