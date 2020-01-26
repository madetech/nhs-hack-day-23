class Session
  attr_accessor :discharge_summary

  def initialize
    @discharge_summary = ''
  end

  def self.decode(json)
    return Session.new if json.nil?
    session_data = JSON.parse(Base64.decode64(json))
    this_session = Session.new
    this_session.discharge_summary = session_data['discharge_summary']
    this_session
  end

  def encode
    Base64.encode64({
      discharge_summary: @discharge_summary
    }.to_json)
  end
end
