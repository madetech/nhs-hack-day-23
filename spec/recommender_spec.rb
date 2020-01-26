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

  def agree_on_recommendation(*args)
    do_full_encode_decode_process
    @recommender.agree_on_recommendation(*args)
  end

  def add_the_seeds
    do_full_encode_decode_process
    @recommender.add_the_seeds
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

    it 'can agree on specific recommendations' do
      new_discharge_summary('this is another discharge summary')
      id = recommendations.last[:id]
      agree_on_recommendation(id)
      agreed_recommendations = recommendations_summary[:recommendations]
      expect(agreed_recommendations[0][:id]).to eq(id)
      expect(agreed_recommendations.length).to eq(1)

    end

    it 'can show the agreed recommendations at the end of the consultation' do
      new_discharge_summary('this is yet another summary')
      recommendations.each do |r|
        agree_on_recommendation(r[:id])
      end
      recommendations = recommendations_summary[:recommendations]
      expect(recommendations[0][:title]).to eq('Tai Chi')
      expect(recommendations[1][:title]).to eq('Walking Group')
      expect(recommendations.length).to eq(2)
    end
  end

  context 'recommendations for the presentation with the seeds' do
    before { add_the_seeds }
    it 'can recommend carer keyword' do
      new_discharge_summary('carer')
      expect(recommendations[0][:title]).to eq("Carers' coffee morning")
      expect(recommendations.length).to eq(1)
    end

    it 'can recommend fall keyword' do
      new_discharge_summary('fall')
      expect(recommendations[0][:title]).to eq("T'ai Chi")
      expect(recommendations.length).to eq(1)
    end

    it 'can recommend fall keyword' do
      new_discharge_summary('sport')
      expect(recommendations[0][:title]).to eq("Wheelchair Basketball")
      expect(recommendations.length).to eq(1)
    end

    it 'can recommend all three keywords' do
      new_discharge_summary('carer fall sport')
      expect(recommendations.length).to eq(3)
    end
  end

  context 'when there are recommendations not available' do
    it 'can show no recommendations' do
      new_discharge_summary('this is a discharge summary')
      expect(recommendations.length).to eq(0)
    end
  end
end
