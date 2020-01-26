before do
  $loader.reload
  @db = HackySessionDatabaseThing.new
  @recommender = @db.decode(cookies[:db])
end

after do
  cookies[:db] = @db.encode(@recommender)
end

get '/seeds' do
  @recommender = HackySessionDatabaseThing.new.decode(nil)
  @recommender.add_recommendation(
    "T'ai Chi",
    'Mondays 9-10am, Central Park'
  )
  @recommender.add_recommendation(
    'Wheelchair Basketball',
    'Saturdays 10-11am, Meet at the entrance to Cardiff University. Free.'
  )
  @recommender.add_recommendation(
    "Carers' coffee morning",
    'Support for those caring for friends/relatives, Tuesdays 11-12. £1 to cover refreshments.'
  )
  @recommender.add_recommendation(
    "Men's choir",
    'Friday evenings 7-9pm, £20 per month.'
  )
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
  erb :recommendations_summary
end

get '/send' do
  @recommender.discharge_summary = ''
  redirect '/?success=true'
end
