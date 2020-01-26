before do
  $loader.reload
  @recommender = HackySessionDatabaseThing.new.decode(request['db'])
  @session = Session.decode(request['session']) #todo: get rid of session class
end

get '/' do
  erb :discharge_summary_step, locals: { success: request['success'] == 'true' }
end

get '/recommendations' do
  @session.discharge_summary = request['discharge-summary']

  recommendations = UseCase::ViewRecommendations.new.execute #todo: get rid of use case class
  erb :recommendations, locals: recommendations.merge(
    session: @session
  )
end

get '/done' do
  erb :recommendations_summary
end

get '/send' do
  redirect '/?success=true'
end
