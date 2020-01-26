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

    @recommendations.select do |r|
      (!@discharge_summary.include?('sport') && !@discharge_summary.include?('fall') && !@discharge_summary.include?('carer')) ||
      (r[:title] == 'Wheelchair Basketball' && @discharge_summary.include?('sport')) ||
      (r[:title] == "T'ai Chi" && @discharge_summary.include?('fall')) ||
      (r[:title] == "Carers' coffee morning" && @discharge_summary.include?('carer'))
    end
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

  def add_the_seeds
    add_recommendation(
      "T'ai Chi",
      'Mondays 9-10am, Central Park'
    )
    add_recommendation(
      'Wheelchair Basketball',
      'Saturdays 10-11am, Meet at the entrance to Cardiff University. Free.'
    )
    add_recommendation(
      "Carers' coffee morning",
      'Support for those caring for friends/relatives, Tuesdays 11-12. £1 to cover refreshments.'
    )
    add_recommendation(
      "Men's choir",
      'Friday evenings 7-9pm, £20 per month.'
    )
  end
end
