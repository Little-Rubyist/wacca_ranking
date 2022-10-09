// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"
import "bootstrap-table"
import jquery from "jquery"
import Rails from '@rails/ujs'
Rails.start();
window.$ = jquery
window.jQuery = jquery

$(function() {
  const updateTextInput = (val) => {
    $('#q_song_difficulty_gteq').val(val)
    $('#q_difficulty_gteq').val(val)
    $('#difficulty-value-id').val(`${val}以上`)
  }

  const resetDifficulty = () => {
    $('#q_song_difficulty_gteq').val(1)
    $('#q_difficulty_gteq').val(1)
    $('#difficulty-value-id').val('未選択')
  }

  $('#q_song_difficulty_gteq').on('input', event => {
    updateTextInput(event.currentTarget.value)
  })
  $('#q_difficulty_gteq').on('input', event => {
    updateTextInput(event.currentTarget.value)
  })
  $('#reset-difficulty-value').on('click', () => {
    resetDifficulty()
  })

  const query = new URLSearchParams(location.search)

  if (query.get('q[song_difficulty_gteq]') !== null) {
    if (query.get('q[song_difficulty_gteq]') > 1) {
      updateTextInput(query.get('q[song_difficulty_gteq]'))
    } else {
      resetDifficulty()
    }
  }
  if (query.get('q[difficulty_gteq]') !== null) {
    if (query.get('q[difficulty_gteq]') > 1) {
      updateTextInput(query.get('q[difficulty_gteq]'))
    } else {
      resetDifficulty()
    }
  }
})
