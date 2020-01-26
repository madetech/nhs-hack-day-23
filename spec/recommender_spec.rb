describe Recommender do
  it 'can store the discharge summary' do
    recommender = described_class.new
    recommender.new_discharge_summary('frail, and various other things')
  end

  it 'can show the recommendations' do
    summary = described_class.new.recommendations_summary

    expect(summary[:recommendations][0][:title]).to eq('Tai Chi')
    expect(summary[:recommendations][1][:title]).to eq('Walking Group')
  end
end
