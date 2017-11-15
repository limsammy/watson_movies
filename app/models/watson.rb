class Watson
  def get_reviews(query)
    api_key = '678f3e381fea4927b1adc2344f5c2631'
    uri = URI("https://api.nytimes.com/svc/movies/v2/reviews/search.json?q=" + query + "&&api-key=#{api_key}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    @result = JSON.parse(http.request(request).body)
    puts @result.inspect
  end

  def get_data(content)
    if content != ""
      response = Excon.post('https://gateway.watsonplatform.net/tone-analyzer/api' + "/v3/tone",
                            :body     => content,
                            :headers  => {
                              "Content-Type"            => "text/plain",
                              "Content-Language"        => "en",
                              "Accept-Language"         => "en"
                            },
                            :query    => {
                              "raw_scores"              => true,
                              "consumption_preferences" => true,
                              "version"                 => "2017-09-21"
                            },
                            :user                       => '45e9abc6-2ff7-4ec9-ab3f-5bf438442b31',
                            :password                   => 'R6rQxWdYOEwH')
      JSON.parse(response.body)['document_tone']['tones']
    else
      return nil
    end
  end
end
