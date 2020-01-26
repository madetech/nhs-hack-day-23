group 'serve' do
  guard :livereload do
    watch(%r{^.*?/(.+)\.(rb|erb|html|css|js)$})
  end
end

group 'tests' do
  guard :rspec, cmd: 'bundle exec rspec' do
    watch(%r{^.*?/(.+)\.rb$}) { 'spec' }
  end
end
