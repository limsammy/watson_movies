class Watson
  def analyze(content)
    
  end

  def get_data(content)
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
  end
end