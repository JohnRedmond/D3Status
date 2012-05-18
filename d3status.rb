require 'nokogiri'
require 'open-uri'

class D3Parser
  BATTLENET_WEB = "http://us.battle.net/d3/en/status"
  DIV_CLASS = "div.status-icon"
  TOOLTIP = "data-tooltip"
  
  def initialize
    doc = Nokogiri::HTML(open(BATTLENET_WEB))
    @html_statuses = doc.search(DIV_CLASS)
    construct_statuses
  end

  def us_server
    @statuses[0]
  end

  private

  def construct_statuses
    @statuses = []
    @html_statuses.each  do |div|
      tooltip_value =div.attributes[TOOLTIP]
      @statuses << tooltip_value.value 
    end
    nil
  end
end




