class AbuseReport
  include MongoMapper::Document
  belongs_to :request, :class_name => "Request"
  belongs_to :blind, :class_name => "Blind"
  belongs_to :helper, :class_name => "Helper"
  key :reason, String, :required => true
  key :reporter, String, :required => true
  timestamps!

  after_save :three_strikes_and_you_are_out
  def three_strikes_and_you_are_out
    if reporter == "blind"
      check(helper) { |helper| AbuseReport.where(:helper_id => helper.id).count}
    else
      check(blind)  { |blind| AbuseReport.where(:blind_id => blind.id).count}
    end
  end

  def check user
    if user.nil?
      return
    end
    no_of_abuses = yield user
    if no_of_abuses == 3
      user.blocked = true
    end
  end
end
