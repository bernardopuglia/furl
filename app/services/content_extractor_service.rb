class ContentExtractorService
  def call(base_url, desired_content)
    content = RestClient.get(base_url).body
    parsed_content = Nokogiri::HTML(content)

    final_stuff = {}

    desired_content.each do |key,value|
      final_stuff.merge!(key => parsed_content.css(key.to_s).map { |tag| tag[value] })
    end

    final_stuff
  end
end