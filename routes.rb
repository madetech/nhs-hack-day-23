before do
  $loader.reload
end

get '/' do
  erb :discharge_summary_step
end

post '/recommendations' do
  recommendations = UseCase::ViewRecommendations.new.execute
  erb :recommendations, locals: recommendations
end
