class AbuseReport
  include MongoMapper::EmbeddedDocument
  embedded_in :user
  belongs_to :request, :foreign_key => :request_id, :class_name => "Request"
  belongs_to :blind, :foreign_key => :blind_id, :class_name => "Blind"
  key :reason, String, :required => true
  key :reporter, String, :required => true
  timestamps!
end
