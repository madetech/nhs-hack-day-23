before do
  $loader.reload
  @db = HackySessionDatabaseThing.new
  @recommender = @db.decode(cookies[:db])
end

after do
  cookies[:db] = @db.encode(@recommender)
end

get '/' do
  erb :discharge_summary_step, locals: { success: request['success'] == 'true' }
end

get '/recommendations' do
  @recommender.new_discharge_summary(request['discharge-summary'])

  erb :recommendations, locals: {
    recommendations: @recommender.recommendations
  }
end

get '/done' do
  erb :recommendations_summary
end

get '/send' do
  redirect '/?success=true'
end
