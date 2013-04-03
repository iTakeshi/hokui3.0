class FreemlEntry < ActiveRecord::Base
  belongs_to :year

  require 'mechanize'

  class << self
    def check_account(year)
      agent = set_agent
      begin
        agent.get(year.freeml_url).body.include?(year.freeml_account)
      rescue Net::HTTPNotFound
        false
      end
    end

    def set_agent
      agent = Mechanize.new
      agent.user_agent_alias = 'Linux Firefox'
      agent.post('http://www.freeml.com/ep.umzx/grid/General/node/SpLoginProcess', APP_CONFIG['freeml'])
      agent
    end
  end

  def body_to_html
    self.body.gsub("\n", "<br>").html_safe
  end

  def to_param
    self.freeml_id
  end
end
