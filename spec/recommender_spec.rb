def do_full_encode_decode_process
  db = HackySessionDatabaseThing.new
  encoded = db.encode(@recommender)
  @recommender = db.decode(encoded)
end

describe Recommender do
  before do
    @recommender = HackySessionDatabaseThing.new.decode(nil)
  end

  def new_discharge_summary(*args)
    do_full_encode_decode_process
    @recommender.new_discharge_summary(*args)
  end

  def recommendations_summary
    do_full_encode_decode_process
    @recommender.recommendations_summary
  end

  def recommendations
    do_full_encode_decode_process
    @recommender.recommendations
  end

  def add_recommendation(*args)
    do_full_encode_decode_process
    @recommender.add_recommendation(*args)
  end

  it 'can store the discharge summary' do
    new_discharge_summary('frail, and various other things')
    discharge_summary = recommendations_summary[:discharge_summary]
    expect(discharge_summary).to eq('frail, and various other things')
  end

  it 'can show no recommendations for a blank discharge summary' do
    expect(recommendations).to eq([])
  end

  context 'when there are already recommendations available' do
    before do
      add_recommendation(
        'Tai Chi',
        '9am-10am'
      )
      add_recommendation(
        'Walking Group',
        '5am'
      )
    end

    it 'can show recommendations when there is a discharge summary' do
      new_discharge_summary('this is a discharge summary')
      expect(recommendations[0][:title]).to eq('Tai Chi')
      expect(recommendations[1][:title]).to eq('Walking Group')
    end

    it 'can show the agreed recommendations at the end of the consultation' do
      recommendations = recommendations_summary[:recommendations]
      expect(recommendations[0][:title]).to eq('Tai Chi')
      expect(recommendations[1][:title]).to eq('Walking Group')
    end
  end

  context 'when there are recommendations not available' do
    it 'can show no recommendations' do
      new_discharge_summary('this is a discharge summary')
      expect(recommendations.length).to eq(0)
    end
  end
end
