describe Recommender do
  it 'can show the recommendations' do
    summary = described_class.new.recommendations_summary

    expect(summary[:recommendations][0][:title]).to eq('Tai Chi')
    expect(summary[:recommendations][1][:title]).to eq('Walking Group')
  end

  
end
