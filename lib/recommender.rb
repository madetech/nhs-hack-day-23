class Recommender
  attr_accessor :summary

  def initialize
    @summary = ''
  end

  def new_discharge_summary(summary)
    @summary = summary
  end

  def recommendations
    return [] if @summary.empty?
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
      discharge_summary: @summary,
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
