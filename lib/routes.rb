before do
  $loader.reload
  @session = Session.decode(request['session'])
end

get '/' do
  erb :discharge_summary_step, locals: { success: request['success'] == 'true' }
end

get '/recommendations' do
  @session.discharge_summary = request['discharge-summary']

  recommendations = UseCase::ViewRecommendations.new.execute
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
