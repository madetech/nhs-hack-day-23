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
