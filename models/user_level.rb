class UserLevel
  include MongoMapper::Document
  key :point_threshold, Integer, :required => true
  key :name, String, :required => true
  many :users, :foreign_key => :user_id, :class_name => "User"
  key :next_user_level_id, ObjectId
  belongs_to :next_user_level, :class_name => 'UserLevel'
  timestamps!
end