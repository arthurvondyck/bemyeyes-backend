class EventLog
    include MongoMapper::Document
    key :name, String, :required => true
    many :event_log_objects
    timestamps!
end
