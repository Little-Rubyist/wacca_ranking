class SongsController < ApplicationController
  def index
    @normal_diff = Song.where(diff_type: :normal).map{|song| { music_id: song.music_id, diff: song.difficulty }}
    @hard_diff = Song.where(diff_type: :hard).map{|song| { music_id: song.music_id, diff: song.difficulty }}
    @expert_diff = Song.where(diff_type: :expert).map{|song| { music_id: song.music_id, diff: song.difficulty }}
    @inferno_diff = Song.where(diff_type: :inferno).map{|song| { music_id: song.music_id, diff: song.difficulty }}
    songs = Song.select('songs.music_id as music_id, MAX(songs.title) as title, MAX(songs.genre) as genre, MAX(songs.can_play_offline) as can_play_offline').group(:music_id)
    @pagy, @songs = pagy(songs, page: params[:page], items: 25, size: [1, 2, 2, 1])
  end

  def show
    @song = Song.find(params[:id])
  end
end
