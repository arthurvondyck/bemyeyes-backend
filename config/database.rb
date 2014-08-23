MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'bemyeyes'
  when :production  then MongoMapper.database = 'bemyeyes'
  when :test        then MongoMapper.database = 'bemyeyes-staging'
end
