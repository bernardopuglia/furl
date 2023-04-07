class ExtractionsController < ApplicationController
  def index
    base_url = params[:base_url]

    if base_url.present?
      @content = ContentExtractorService.new.call(base_url, {'img': 'src', 'a': 'href'})
    end
  rescue StandardError => error
    @error = error.message
  end
end