module ApplicationHelper
  require "addressable/uri"

  def locale_path(locale)
    uri = Addressable::URI.parse(request.url)
    params = uri.query_values
    if params.nil?
      params = { 'locale'=> 'ja' }
    end
    params['locale'] = locale
    uri.query_values = params
    uri.to_s
  end
end
