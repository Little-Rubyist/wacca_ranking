require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'have master song data' do
    expect(Song.all.size).to eq 1139
  end
end
