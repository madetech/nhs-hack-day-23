require 'zeitwerk'

$loader = Zeitwerk::Loader.new
$loader.push_dir("#{__dir__}/lib/")
$loader.enable_reloading

$: << "#{__dir__}/lib/"

