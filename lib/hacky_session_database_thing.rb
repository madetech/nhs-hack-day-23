require 'base64'
require 'json'
class HackySessionDatabaseThing
  def encode(recommender)
    Base64.encode64(
      {
        discharge_summary: recommender.discharge_summary,
        recommendations: recommender._recommendations
      }.to_json
    )
  end

  def decode(base64)
    return Recommender.new if base64.nil?
    hash = JSON.parse(Base64.decode64(base64))

    recommender = Recommender.new
    recommender.discharge_summary = hash['discharge_summary']
    recommender.recommendations = (hash['recommendations'] || []).map(&method(:symbolize))
    recommender
  end

  def symbolize(hash)
    hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end
end
