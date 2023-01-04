// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "popper"
import "bootstrap"
import "bootstrap-table"
import jquery from "jquery"
import Rails from '@rails/ujs'
import I18n from 'i18n-js/translations'
Rails.start();
window.$ = jquery
window.jQuery = jquery

$(function() {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
  const query = new URLSearchParams(location.search)
  I18n.defaultLocale = 'ja'
  I18n.locale = query.get('locale')

  const updateTextInput = (val) => {
    $('#q_song_difficulty_gteq').val(val)
    $('#q_difficulty_gteq').val(val)
    $('#difficulty-value-id').val(`${val} ${I18n.t('views.user_songs.or_more')}`)
  }

  const resetDifficulty = () => {
    $('#q_song_difficulty_gteq').val(1)
    $('#q_difficulty_gteq').val(1)
    $('#difficulty-value-id').val(I18n.t('views.user_songs.unselect'))
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
