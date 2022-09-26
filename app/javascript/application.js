// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"
import Rails from '@rails/ujs';
Rails.start();
console.log('yeah, we are ready!')
window.updateTextInput = function(val) {
  document.getElementById('difficulty-value-id').value = `${val}以上`
}

window.resetDifficulty = function () {
  document.getElementById('q_song_difficulty_gteq').value = 1
  document.getElementById('difficulty-value-id').value = '未選択'
}

if (document.getElementById('q_song_difficulty_gteq').value > 1) {
  updateTextInput(document.getElementById('q_song_difficulty_gteq').value)
} else {
  resetDifficulty()
}
