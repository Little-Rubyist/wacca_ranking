class HomeController < ApplicationController
  def index
  end

  def policies
  end

  def agreement
  end

  def information
  end

  def sponsors
  end

  def gallery_songs
    @songs = Song.select('songs.music_id, MAX(songs.title) as title, MAX(songs.title_english) as title_english').group(:music_id)
  end

  def gallery_icons
  end

  def gallery_plates
  end
end
