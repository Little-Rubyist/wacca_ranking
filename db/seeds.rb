# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "csv"

# master data
console_colors = []
custom_titles = []
icons = []
navigators = []
plates = []
songs = []
titles = []
stageups = []

CSV.foreach('db/csvs/console_colors.csv', headers: true) do |row|
  console_colors << {id: row['id'],
                    name: row['name']}
end
ConsoleColor.insert_all(console_colors)

CSV.foreach('db/csvs/custom_titles.csv', headers: true) do |row|
  custom_titles << {id: row['id'],
                   name: row['part']}
end
CustomTitle.insert_all(custom_titles)

CSV.foreach('db/csvs/icons.csv', headers: true) do |row|
  icons << {id: row['id'],
            name: row['name'],
            rarity: row['rarity']}
end
Icon.insert_all(icons)

CSV.foreach('db/csvs/navigators.csv', headers: true) do |row|
  navigators << {id: row['id'],
                    name: row['name']}
end
Navigator.insert_all(navigators)

CSV.foreach('db/csvs/plates.csv', headers: true) do |row|
  plates << {id: row['id'],
             name: row['name'],
             rarity: row['rarity']}
end
Plate.insert_all(plates)

CSV.foreach('db/csvs/titles.csv', headers: true) do |row|
  titles << {id: row['id'],
             custom1: row['custom1'],
             custom2: row['custom2'],
             custom3: row['custom3'],
             name: row['title'],
             rarity: row['rarity']}
end
Title.insert_all(titles)

CSV.foreach('db/csvs/songs.csv', headers: true) do |row|
  songs << {id: row['id'],
            title: row['title'],
            title_english: row['title_english'],
            ruby: row['ruby'],
            music_id: row['music_id'],
            can_play_offline: row['can_play_offline'],
            genre: row['genre'],
            diff_type: row['diff_type'],
            difficulty: row['difficulty'] }
end
Song.insert_all(songs)

CSV.foreach('db/csvs/stageups.csv', headers: true) do |row|
  stageups << {id: row['id'],
               title: row['title'],
               first_song_id: row['first'],
               second_song_id: row['second'],
               last_song_id: row['last']}
end
Stageup.insert_all(stageups)

