class Recommender
  attr_accessor :discharge_summary

  def initialize
    @discharge_summary = ''
  end

  def new_discharge_summary(summary)
    @discharge_summary = summary
  end

  def recommendations
    return [] if @discharge_summary.empty?
    [
      {
        title: 'Tai Chi'
      },
      {
        title: 'Walking Group'
      }
    ]
  end

  def recommendations_summary
    {
      discharge_summary: @discharge_summary,
      recommendations: [
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
