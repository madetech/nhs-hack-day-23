before do
  $loader.reload
end

get '/' do
  erb :discharge_summary_step, locals: { success: request['success'] == 'true' }
end

get '/recommendations' do
  recommendations = UseCase::ViewRecommendations.new.execute
  erb :recommendations, locals: recommendations
end

get '/done' do
  erb :recommendations_summary
end

get '/send' do
  redirect '/?success=true'
end
