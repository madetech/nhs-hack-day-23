def reset
  @recommender = HackySessionDatabaseThing.new.decode(nil)
end

before do
  $loader.reload
  @db = HackySessionDatabaseThing.new
  @recommender = @db.decode(cookies[:db])
end

after do
  cookies[:db] = @db.encode(@recommender)
end

get '/reset' do
  reset
  redirect '/'
end

get '/seeds' do
  reset
  @recommender.add_the_seeds
  redirect '/'
end

get '/adam' do
  @recommender.new_discharge_summary("Adam (21) has been seen by the Occupational Therapist following a spinal cord injury. He is a new wheelchair user. He is keen to return to paid employment and sport. Prior to his injury, he was a carer for his Mum.")
  redirect '/'
end

get '/betty' do
  @recommender.new_discharge_summary("Betty (85) was referred for Physiotherapy to improve her mobility after being in hospital due to a fall and broken hip (which was repaired). She is now able to walk short distances with a walking stick and is keen to progress her walking. She continues to be the main carer for her husband, who has moderate Alzheimer's.")
  redirect '/'
end

get '/' do
  erb :discharge_summary_step, locals: { success: request['success'] == 'true' }
end

get '/recommendations' do
  unless request['discharge-summary'].nil?
    @recommender.new_discharge_summary(request['discharge-summary'])
  end

  erb :recommendations, locals: {
    recommendations: @recommender.recommendations
  }
end

get '/done' do
  selected_recommendation_ids = request['selected_recommendation']
  selected_recommendation_ids.each do |id|
    @recommender.agree_on_recommendation(id)
  end

  erb :recommendations_summary
end

get '/send' do
  @recommender.discharge_summary = ''
  @recommender.agreed_recommendations = []
  redirect '/?success=true'
end
