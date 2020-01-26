describe Recommender do
  let(:recommender) { described_class.new }

  def new_discharge_summary(*args)
    recommender.new_discharge_summary(*args)
  end

  it 'can store the discharge summary' do
    new_discharge_summary('frail, and various other things')
    discharge_summary = recommender.recommendations_summary[:discharge_summary]
    expect(discharge_summary).to eq('frail, and various other things')
  end


  it 'can show no recommendations for a blank discharge summary' do
    recommendations = recommender.recommendations
    expect(recommendations).to eq([])
  end

  it 'can show recommendations when there is a discharge summary' do
    recommender.new_discharge_summary('this is a discharge summary')
    recommendations = recommender.recommendations
    expect(recommendations[0][:title]).to eq('Tai Chi')
    expect(recommendations[1][:title]).to eq('Walking Group')
  end

  it 'can show the agreed recommendations at the end of the consultation' do
    summary = recommender.recommendations_summary

    recommendations = summary[:recommendations]
    expect(recommendations[0][:title]).to eq('Tai Chi')
    expect(recommendations[1][:title]).to eq('Walking Group')
  end
end
