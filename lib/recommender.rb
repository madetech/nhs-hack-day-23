require 'securerandom'

class Recommender
  attr_accessor :discharge_summary
  attr_accessor :agreed_recommendations
  attr_writer :recommendations

  def initialize
    @discharge_summary = ''
    @recommendations = []
    @agreed_recommendations = []
  end

  def _recommendations
    @recommendations
  end

  def add_recommendation(title, description)
    @recommendations << {
      id: SecureRandom.uuid,
      title: title,
      description: description
    }
  end

  def new_discharge_summary(summary)
    @discharge_summary = summary
  end

  def recommendations
    return [] if @discharge_summary.empty?
    @recommendations
  end

  def agree_on_recommendation(id)
    @agreed_recommendations << id
  end

  def recommendations_summary
    {
      discharge_summary: @discharge_summary,
      recommendations: @recommendations.select do |r|
        @agreed_recommendations.include?(r[:id])
      end
    }
  end
end
