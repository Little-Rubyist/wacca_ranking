class SongsController < ApplicationController
  def index
  end

  def show
    @song = Song.find(params[:id])
  end
end
