class EventLogObject
    include MongoMapper::EmbeddedDocument
    key :name, String, :required => true
    key :json_serialized, :required => true
end
