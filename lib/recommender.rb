class Recommender
  attr_accessor :discharge_summary
  attr_writer :recommendations

  def initialize
    @discharge_summary = ''
    @recommendations = []
  end

  def _recommendations
    @recommendations
  end

  def add_recommendation(title, description)
    @recommendations << {title: title, description: description}
  end

  def new_discharge_summary(summary)
    @discharge_summary = summary
  end

  def recommendations
    return [] if @discharge_summary.empty?
    @recommendations
  end

  def recommendations_summary
    {
      discharge_summary: @discharge_summary,
      recommendations: [ #todo these are "agreed recommendations" and should be displayed based on the checkboxes
        {
          title: 'Tai Chi'
        },
        {
          title: 'Walking Group'
        }
      ]
    }
  end
end
