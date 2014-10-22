require_relative 'request'
require_relative 'user'

Dir[File.join(File.dirname(__FILE__), '..',  'models', '**/*.rb')].sort.each do |file|
  require file
end
