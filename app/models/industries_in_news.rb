class IndustriesInNews < ActiveRecord::Base
  belongs_to :feed_entry
  belongs_to :industry
  validates :news_id,:industry_id , :presence => true
  validates :industry_id,:scope=>[:feed_entry_id] ,:uniqueness => true
  
  def self.create_industry_tag news_id, name
    unless name.nil?
      industries = IndustriesInNews.matching_industries(name)
      industries.each do |industry|
        IndustriesInNews.find_or_create_by_feed_entry_id_and_industry_id :feed_entry_id=>news_id, :industry_id=>industry.id unless industry.nil?
      end
    end
  end
  
  def self.matching_industries name
    tokens = name.split(/\W/).compact
    
    search_param = tokens.map { |k|
      "industries.name LIKE '%%#{k.stem}%%'"
    }.join(' AND ')
    
    Industry.find :all, :conditions=> search_param
  end
end
