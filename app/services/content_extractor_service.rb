class ContentExtractorService
  def call(base_url, desired_content)
    content = RestClient.get(base_url).body
    parsed_content = Nokogiri::HTML(content)

    extracted_content = {}

    desired_content.each do |key, value|
      extracted_content.merge!(key => parsed_content.css(key.to_s).map { |tag| tag[value] })
    end

    extracted_content
  rescue URI::InvalidURIError
    raise "URL is invalid: #{base_url}"
  rescue StandardError => error
    raise "An unexpected error has occured: #{error.message}"
  end
end