class HelperRequest
  include MongoMapper::Document

  belongs_to :request, :class_name => "Request"
  belongs_to :helper, :class_name => "Helper"

  timestamps!

  key :cancelled, Boolean, :default => false
  key :cancel_notification_sent, Boolean, :default => false
end
