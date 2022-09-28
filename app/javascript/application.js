// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"
import Rails from '@rails/ujs';
Rails.start();

window.updateTextInput = function(val) {
  document.getElementById('difficulty-value-id').value = `${val}以上`
}

window.resetDifficulty = function () {
  document.getElementById('q_song_difficulty_gteq').value = 1
  document.getElementById('q_difficulty_gteq').value = 1
  document.getElementById('difficulty-value-id').value = '未選択'
}

if (document.getElementById('q_song_difficulty_gteq').value > 1) {
  updateTextInput(document.getElementById('q_song_difficulty_gteq').value)
} else {
  resetDifficulty()
}

if (document.getElementById('q_difficulty_gteq').value > 1) {
  updateTextInput(document.getElementById('q_difficulty_gteq').value)
} else {
  resetDifficulty()
}
