require 'base64'
require 'json'
class HackySessionDatabaseThing
  def encode(recommender)
    Base64.encode64(
      {
        discharge_summary: recommender.summary
      }.to_json
    )
  end

  def decode(base64)
    hash = JSON.parse(Base64.decode64(base64))

    recommender = Recommender.new
    recommender.summary = hash['discharge_summary']
    recommender
  end
end
