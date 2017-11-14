class Document < ApplicationRecord
  after_create :save_data
  has_many :tones

  def save_data
    self.get_data.each do |tone|
      binding.pry
      tone_name = tone['tone_name']
      tone_score = tone['score'].to_f
      self.tones.create(tone_id: tone_name, tone_score: tone_score)
    end
    binding.pry
  end

  def get_data
    response = Excon.post('https://gateway.watsonplatform.net/tone-analyzer/api' + "/v3/tone",
    :body     => self.body,
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
