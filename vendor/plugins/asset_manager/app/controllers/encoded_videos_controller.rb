class EncodedVideosController < ApplicationController
  def show
    @video = EncodedVideo.find(params[:id])
  end
end
